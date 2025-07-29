from typing import Optional, Type, TypeVar

from django.core.exceptions import ValidationError

T = TypeVar('T')

def get_object_or_error(model: Type[T], object_id: int, error_message: Optional[str] = None) -> T:
    try:
        return model.objects.get(id=object_id)
    except model.DoesNotExist:
        message = error_message or f"{model.__name__} with id {object_id} not found."
        raise ValidationError(message)
