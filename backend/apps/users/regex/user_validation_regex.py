from enum import Enum

from django.utils.translation import gettext_lazy as _


class UserValidationRegex(Enum):
    NAME = (
        r"^(?=.{2,25}$)[A-ZА-ЯЇІЄҐ][a-zа-яїієґ]*(?:-[A-ZА-ЯЇІЄҐ][a-zа-яїієґ]*)?$",
        _("Must start with a capital letter and contain only the letters"),
    )

    ZIP_CODE = (
        r"^(\d{5}(-\d{4})?|[A-Z]\d[A-Z][ -]?\d[A-Z]\d|[A-Z]{1,2}\d[A-Z\d]?\s?\d[A-Z]{2})$",
        _(
            "Zip code format must be as follows: 12345, 12345-6789, K1A 0B1, SW1A 1AA, 75008, 01001"
        ),
    )

    def __init__(self, pattern: str, msg: str):
        self.pattern = pattern
        self.msg = msg
