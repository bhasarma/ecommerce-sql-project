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

_REALISTIC_HOUR_WEIGHTS = (
    0.08, 0.05, 0.04, 0.03, 0.04, 0.08,
    0.18, 0.34, 0.52, 0.68, 0.78, 0.86,
    0.92, 0.88, 0.84, 0.82, 0.88, 0.98,
    1.00, 0.94, 0.78, 0.52, 0.30, 0.16,
)
_HOURS = tuple(range(24))
_HOUR_MICROSECONDS = 3_600_000_000
_DAY_WEIGHTED_MICROSECONDS = sum(_REALISTIC_HOUR_WEIGHTS) * _HOUR_MICROSECONDS

#===============================================================
# Project directories
#===============================================================

PROJECT_ROOT = Path(__file__).resolve().parent

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


def load_text_resource(filename: str) -> list[str]:
    '''
    Load a text resource file.

    Each non-empty line in the file is returned as one list element.

    Parameters:
    -----------
    list[str]
        List of strings from the file.
    '''

    file_path = RESOURCES_DIR/filename

    with file_path.open("r", encoding="utf-8") as file:
        return [
            line.strip()
            for line in file
            if line.strip()
        ]

def load_json_resource(filename: str) -> dict[str, Any]:
    '''
    Load a json resource file

    Parameters:
    -----------
    filename: str
        Name of the JSON file inside the resources directory.

    Returns:
    --------
    dict[str, Any]
        Parsed JSON content.
    '''

    file_path = RESOURCES_DIR/filename

    with file_path.open("r",encoding = "utf-8") as file:
        return json.load(file)
    
def random_date_between(start_date: date, end_date: date) -> date:
    '''
    Generate a random date between two dates (inclusive).

    Parameters:
    -----------
    start_date: date
        Earliest possible date

    end_date: date
        Latest possible date

    Returns:
    ---------
    date
        Randomly selected date
    '''

    if start_date > end_date:
        raise ValueError("start_date must not be later than end_date")
    
    days_between = (end_date - start_date).days

    random_days = random.randint(0, days_between)

    return start_date + timedelta(days=random_days)


def _microseconds_between(start_datetime: datetime, end_datetime: datetime) -> int:
    delta = end_datetime - start_datetime
    return (delta.days * 86_400 + delta.seconds) * 1_000_000 + delta.microseconds


def _weighted_span_total(start_datetime: datetime, end_datetime: datetime) -> float:
    total = 0.0
    current = start_datetime.replace(minute=0, second=0, microsecond=0)

    while current < end_datetime:
        bucket_start = max(start_datetime, current)
        bucket_end = min(end_datetime, current + timedelta(hours=1))
        duration = _microseconds_between(bucket_start, bucket_end)
        if duration > 0:
            total += duration * _REALISTIC_HOUR_WEIGHTS[current.hour]
        current += timedelta(hours=1)

    return total


def _weighted_datetime_in_span(
        start_datetime: datetime,
        end_datetime: datetime,
) -> datetime:
    candidates: list[tuple[datetime, int, float]] = []
    current = start_datetime.replace(minute=0, second=0, microsecond=0)

    while current < end_datetime:
        bucket_start = max(start_datetime, current)
        bucket_end = min(end_datetime, current + timedelta(hours=1))
        duration = _microseconds_between(bucket_start, bucket_end)
        if duration > 0:
            candidates.append(
                (
                    bucket_start,
                    duration,
                    duration * _REALISTIC_HOUR_WEIGHTS[current.hour],
                )
            )
        current += timedelta(hours=1)

    bucket_start, duration, _ = random.choices(
        candidates,
        weights=[candidate[2] for candidate in candidates],
        k=1,
    )[0]

    return bucket_start + timedelta(microseconds=random.randrange(duration))


def random_datetime_between(
        start_datetime: datetime,
        end_datetime: datetime,
) -> datetime:
    '''
    Generate a random datetime between two datetimes (inclusive)

    Parameters:
    -----------
    start_datetime: datetime
        Earliest possible datetime
    end_datetime: datetime
        Latest possible datetime

    Returns:
    --------
    datetime
        Randomly selected datetime
    '''

    if start_datetime > end_datetime:
        raise ValueError(
            "start_datetime must not be later than end_datetime."
        )
    
    if start_datetime == end_datetime:
        return start_datetime

    try:
        end_exclusive = end_datetime + timedelta(microseconds=1)
    except OverflowError:
        end_exclusive = end_datetime
    start_midnight = start_datetime.replace(hour=0, minute=0, second=0, microsecond=0)
    middle_start = start_midnight
    if start_datetime > start_midnight:
        middle_start += timedelta(days=1)
    middle_end = end_exclusive.replace(hour=0, minute=0, second=0, microsecond=0)

    segments: list[tuple[str, datetime, datetime, float]] = []
    start_partial_end = min(end_exclusive, middle_start)
    if start_datetime < start_partial_end:
        segments.append(
            (
                "partial",
                start_datetime,
                start_partial_end,
                _weighted_span_total(start_datetime, start_partial_end),
            )
        )

    full_days = max((middle_end - middle_start).days, 0)
    if full_days:
        segments.append(
            (
                "full",
                middle_start,
                middle_end,
                full_days * _DAY_WEIGHTED_MICROSECONDS,
            )
        )

    end_partial_start = max(start_datetime, middle_end)
    if end_partial_start < end_exclusive:
        segments.append(
            (
                "partial",
                end_partial_start,
                end_exclusive,
                _weighted_span_total(end_partial_start, end_exclusive),
            )
        )

    segment_type, segment_start, segment_end, _ = random.choices(
        segments,
        weights=[segment[3] for segment in segments],
        k=1,
    )[0]

    if segment_type == "partial":
        return _weighted_datetime_in_span(segment_start, segment_end)

    day_offset = random.randrange((segment_end - segment_start).days)
    hour = random.choices(_HOURS, weights=_REALISTIC_HOUR_WEIGHTS, k=1)[0]
    return (
        segment_start
        + timedelta(days=day_offset, hours=hour)
        + timedelta(microseconds=random.randrange(_HOUR_MICROSECONDS))
    )
