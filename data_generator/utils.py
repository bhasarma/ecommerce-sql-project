'''
Shared utility functions for the Ecommerce SQL project

Idea is that all functions in this module should be generic and
reusable across multiple data generators.
'''

from __future__ import annotations

import json
import random

from datetime import date, datetime, timedelta
from pathlib import Path
from typing import Any

import numpy as np

#===============================================================
# Project directories
#===============================================================

PROJECT_ROOT = Path(__file__).resolve.parent

RESOURCES_DIR = PROJECT_ROOT / "resources"

def initialize_random_seed(seed : int) -> None:
    '''
    Initialize Python's and NumPy's random number generators.

    Using the same seed ensures that the generated dataset is
    completely reprodicible. 

    Parameters:
    ------------
    seed: int
        Random seed.
    '''

    random.seed(seed)
    np.random.seed(seed)


def weighted_choice(weights: dict[str, float]) -> str:
    '''
    Select a random value according to the suplied probability weights.

    Parameters:
    -----------
    weights: dict[str, float]
        Dictionary mapping values to their probabilities

    Returns
    -------
    str
        One randomly selected key
    '''

    return random.choices(
        population = list(weights.keys()),
        weights = list(weights.values()),
        k=1
    )[0]


