from django.contrib.auth import get_user_model
from django.db import models
from django.utils import timezone

from apps.products.models import Accessory, Product

UserModel = get_user_model()


class Order(models.Model):

    class Meta:
        db_table = "order"
        ordering = ("id",)

    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
        ('in_progress', 'In Progress'),
        ('delivered', 'Delivered'),
    ]

    order_notes = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        UserModel,
        on_delete=models.CASCADE, 
        related_name='orders'
    )
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f"Order #{self.id} by {self.customer.email}"

    
class OrderPosition(models.Model):

    class Meta:
        db_table = "order_position"
        ordering = ("id",)

    quantity = models.IntegerField(default=1)
    total_price = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0.00
    )
    date = models.DateTimeField(default=timezone.now)
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        related_name='positions',
    )
    product = models.ForeignKey(
        Product,
        null=True,
        blank=True,
        on_delete=models.PROTECT,
        related_name='order_positions'
    )
    accessory = models.ForeignKey(
        Accessory,
        null=True,
        blank=True,
        on_delete=models.PROTECT,
        related_name='accessory_positions'
    )

    def __str__(self):
        return f"{self.quantity}x {self.product.name} in Order #{self.order.id}"

