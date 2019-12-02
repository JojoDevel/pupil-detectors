# pupil-detectors

This is a python-package containing standalone pupil detectors for the [Pupil-Labs](https://pupil-labs.com/) software stack. It contains the following detectors:

- Detector2D
- Detector3D

## Installation (wheels)

This package has a couple of non-python dependencies that you will have to install yourself. To make this easier, we provide prebuilt-wheels for major operating systems, containing some of the dependencies already.

Since pupil-detectors use some shared libraries, you will have to make sure those are installed. Until we have a clear description on how to install the necessary requirements for every platform, we assume you are using **pupil-detectors** in the context of the Pupil-Labs software stack. In this case you should have all necessary dependencies set up already. You can find the dependencies for Pupil on [the Pupil GitHub page](https://github.com/pupil-labs/pupil#installing-dependencies). Not all of them are necessary for **pupil-detectors** and we are working on specific install instructions only for this package.

When you have all nessecary dependencies, you can install **pupil-detectors** with
```bash
pip install pupil-detectors
```

## Usage

Here's a quick example on how to detect and draw an ellipse.

```python
import cv2
from pupil_detectors import Detector2D, Detector3D

detector = Detector2D()

# read image as numpy array from somewhere, e.g. here from a file
img = cv2.imread("pupil.png")
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

result = detector.detect(gray)
ellipse = result["ellipse"]

# draw the ellipse outline onto the input image
# note that cv2.ellipse() cannot deal with float values
# also it expects the axes to be semi-axes (half the size)
cv2.ellipse(
    img,
    tuple(int(v) for v in ellipse["center"]),
    tuple(int(v / 2) for v in ellipse["axes"]),
    ellipse["angle"],
    0, 360, # start/end angle for drawing
    (0, 0, 255) # color (BGR): red
)
cv2.imshow("Image", img)
cv2.waitKey(0)
```

## Developers

### Build from Source

You can install this package locally from source. Make sure you have all necessary dependencies setup (see Installation section above). 

**NOTE:** When building the package on your own, you can experience severe performance differences when not having setup your dependencies correctly. Make sure to compare performance to prebuilt wheels or to bundled versions of [Pupil](https://github.com/pupil-labs/pupil).

```bash
# Clone repository
git clone git@github.com:pupil-labs/pupil-detectors.git
cd pupil-detectors

# Install from source with development extras
pip install ".[dev]"

# Run tests
pytest tests
```