from django.core.exceptions import ValidationError
from django.db import IntegrityError, transaction

from apps.db_utils import get_object_or_error
from apps.products.models import FlavorProfile, Product


@transaction.atomic
def create_product(data: dict) -> Product:
    # check required fields
    sku = data.get("sku")
    name = data.get("name")
    brand = data.get("brand")
    sort = data.get("sort")
    roast = data.get("roast")
    if not sku:
        raise ValidationError("Product 'sku' field is required.")
    if not name:
        raise ValidationError("Product 'name' field is required.")
    if not brand:
        raise ValidationError("Product 'brand' field is required.")
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
            sku=sku,
            name=name,
            brend=brand,
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


def get_product_all() -> tuple:
    return Product.objects.prefetch_related('photos', 'supplies').all()


@transaction.atomic
def update_product(product_id: int, data: dict) -> Product:
    product = get_object_or_error(Product, product_id)
    
    product.sku = data.get("sku", product.sku)
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
        raise ValueError(f"Cannot delete products {product_id}: {str(e)}")