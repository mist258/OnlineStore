from django.conf import settings
from django.db import models
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply


class Favorites(models.Model):
    """
    Represents a user's favorite items collection.
    """
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="favorites",
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Favorites for {self.user}"

    class Meta:
        verbose_name_plural = "Favorites"


class FavoriteItem(models.Model):
    """
    Items marked as favorite by the user.
    """
    favorites = models.ForeignKey(
        Favorites,
        on_delete=models.CASCADE,
        related_name="items"
    )
    accessory = models.ForeignKey(
        Accessory,
        on_delete=models.CASCADE,
        related_name="favorite_items",
        null=True,
        blank=True
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name="favorite_items",
        null=True,
        blank=True
    )
    supply = models.ForeignKey(
        Supply,
        related_name='favorite_items',
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )
    added_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['favorites', 'product', 'accessory', 'supply'],
                name='unique_favorite_item'
            )
        ]

    def __str__(self):
        item_type = self.product or self.accessory or self.supply
        return f"{item_type} in {self.favorites.user}'s favorites"