from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.check_deployment.db_utils import get_object_or_error
from apps.check_deployment.models import FlavorProfile, Product


@transaction.atomic
def create_product(data: dict) -> Product:
    # check required fields
    name = data.get("name")
    brend = data.get("brend")
    sort = data.get("sort")
    roast=data.get("roast")
    if not name:
        raise ValidationError("Product 'name' field is required.")
    if not brend:
        raise ValidationError("Product 'brend' field is required.")
    if not sort:
        raise ValidationError("Product 'sort' field is required.")
    if not roast:
        raise ValidationError("Product 'roast' field is required.")
    
    # process flavor profiles
    flavor_names = data.get("flavor_profiles", [])
    flavors = [
        FlavorProfile.objects.get_or_create(name=name.strip())[0]
        for name in flavor_names
    ]

    try:
        product = Product.objects.create(
            name=name,
            brend=brend,
            caffeine_type=data.get("caffeine_type"),
            sort=sort,
            roast=roast,
            description=data.get("description")
        )
        product.flavor_profiles.set(flavors)
    except IntegrityError as e:
        raise ValidationError(f"Database error: {str(e)}")
    except Exception as e:
        raise ValidationError(f"Unexpected error: {str(e)}")

    return product


def get_product_by_id(product_id: int) -> Product:
    return get_object_or_error(Product, product_id)


@transaction.atomic
def update_product(product_id: int, data: dict) -> Product:
    product = get_object_or_error(Product, product_id)
    
    product.name = data.get("name", product.name)
    product.brend = data.get("brend", product.brend)
    product.caffeine_type = data.get("caffeine_type", product.caffeine_type)
    product.sort = data.get("sort", product.sort)
    product.roast = data.get("roast", product.roast)
    product.description = data.get("description", product.description)
    product.save()

    if "flavor_profiles" in data:
        flavor_names = data["flavor_profiles"]
        flavors = [
            FlavorProfile.objects.get_or_create(name=name.strip())[0]
            for name in flavor_names
        ]        
        product.flavor_profiles.set(flavors)
    return product


@transaction.atomic
def delete_product(product_id: int) -> None:
    product = get_object_or_error(Product, product_id)

    try:
        product.delete()
    except Product.DoesNotExist:
        raise ValueError(f"Product with id {product_id} not found.")
    except IntegrityError as e:
        raise ValueError(f"Cannot delete product {product_id}: {str(e)}")

