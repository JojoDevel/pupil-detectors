import typing as T

import numpy as np


cdef class DetectorBase:
    """Base interface for pupil detectors."""

    # abstract interface

    def detect(self, gray_img: np.nparray, **kwargs) -> T.Dict[str, T.Any]:
        """Detect pupil location in input image.
        
        Parameters:
            gray_img: input image as 2D numpy array (grayscale)

        Returns:
            Dictionary with information about the pupil.
            Minimum required keys are:
                location (int, int): location of the pupil in image space
                confidence (int): confidence of the algorithm in [0, 1]
            More keys can be added for custom functionality when subclassing.
        """
        raise NotImplementedError()
    
    def get_property_namespaces(self) -> T.Iterable[str]:
        """Returns a list of property namespaces that the detector supports."""
        raise NotImplementedError()

    def get_properties(self, namespace: str) -> T.Dict[str, T.Any]:
        """Returns current properties for a given namespace."""
        raise NotImplementedError()

    def set_properties(self, namespace: str, properties: T.Dict[str, T.Any]) -> None:
        """Sets all properties for a given namespace."""
        raise NotImplementedError()

    # convenience functions

    def get_all_properties(self) -> T.Dict[str, T.Dict[str, T.Any]]:
        """Returns all current properties for all namespaces."""
        return {
            namespace: self.get_properties(namespace)
            for namespace in self.get_property_namespaces()
        }


cdef class TemporalDetectorBase(DetectorBase):
    """Base interface for pupil detectors that work on temporal data."""

    def detect(
        self,
        gray_img: np.nparray,
        timestamp: float,
        **kwargs
    ) -> T.Dict[str, T.Any]:
        """Detect pupil location in input image.
        
        Parameters:
            gray_img: input image as 2D numpy array (grayscale)
            timestamp: timing information for correlating sequential images

        Returns:
            Dictionary with information about the pupil.
            Minimum required keys are:
                location (int, int): location of the pupil in image space
                confidence (int): confidence of the algorithm in [0, 1]
                timestamp (float): the timestamp of the input
            More keys can be added for custom functionality when subclassing.
        """
        raise NotImplementedError()
