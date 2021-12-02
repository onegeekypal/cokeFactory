from enum import Enum


class TransactionType(Enum):
    RATE = "RATE"
    ERRORS = "ERRORS"
    STATUS = "STATUS"
