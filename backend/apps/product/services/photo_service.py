from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.db_utils import get_object_or_error
from apps.product.models import Photo, Product


@transaction.atomic
def create_photo(data: dict) -> Photo:
    product_id = data.get("product_id")
    url = data.get("url")
    position = data.get("position", 0)

    if not product_id:
        raise ValidationError("product_id is required.")

    product = get_object_or_error(Product, product_id)

    try:
        photo = Photo.objects.create(
            product=product,
            url=url,
            position=position
        )
    except IntegrityError as e:
        raise ValidationError(f"Failed to create photo: {e}")

    return photo


@transaction.atomic
def update_photo(photo_id: int, data: dict) -> Photo:
    photo = get_object_or_error(Photo, photo_id)

    if "url" in data:
        photo.url = data["url"]
    if "position" in data:
        photo.position = data["position"]
    if "product_id" in data:
        product = get_object_or_error(Product, data["product_id"])
        photo.product = product

    photo.save()
    return photo


@transaction.atomic
def delete_photo(photo_id: int) -> None:
    photo = get_object_or_error(Photo, photo_id)

    try:
        photo.delete()
    except IntegrityError as e:
        raise ValidationError(f"Failed to delete photo {photo_id}: {e}")


def get_photo_by_id(photo_id: int) -> Photo:
    return get_object_or_error(Photo, photo_id)
