from django.db import models
from apps.product.models import Product
from apps.customer.models import Customer
from backend.apps.utils import get_timenow
    

class Order(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('approved', 'Approved'),
        ('rejected', 'Rejected'),
        ('in_progress', 'In Progress'),
        ('delivered', 'Delivered'),
    ]

    order_notes = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        Customer, 
        on_delete=models.CASCADE, 
        related_name='orders'
    )
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='pending')

    def __str__(self):
        return f"Order #{self.id} by {self.customer.email}"


class OrderPosition(models.Model):
    quantity = models.IntegerField(default=1)
    total_price = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        default=0.00
    )
    date = models.DateField(default=get_timenow)
    product = models.ForeignKey(
        Product, 
        null=True,
        blank=True,
        on_delete=models.PROTECT,
        related_name='order_positions'
    )
    order = models.ForeignKey(
        Order, 
        on_delete=models.CASCADE, 
        related_name='positions'
    )

    def __str__(self):
        return f"{self.quantity}x {self.product.name} in Order #{self.order.id}"