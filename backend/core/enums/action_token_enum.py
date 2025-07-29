from datetime import timedelta
from enum import Enum


class ActionTokenEnum(Enum):

    RECOVERY = (
        'recovery',
        timedelta(minutes=59),

    )

    ACCESS = (
        'access',
        timedelta(minutes=59),
    )

    REFRESH = (
        'refresh',
        timedelta(minutes=59),
    )

    def __init__(self, token_type, lifetime):
        self.token_type = token_type
        self.lifetime = lifetime
