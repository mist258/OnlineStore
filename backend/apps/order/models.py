from django.contrib.auth import get_user_model
from django.db import models

from apps.products.models import Product
from apps.users.models import UserProfileModel
from apps.utils import get_timenow
from core.services.email_service import send_order_status_email

UserModel = get_user_model()


class Order(models.Model):

    class Meta:
        db_table = "order"
        ordering = ("id",)

    STATUS_CHOICES = [
        ('processing', 'Order in processing'),
        ('preparing', 'Preparing'),
        ('shipping', 'Shipping'),
        ('in_transit', 'In transit'),
        ('delivered', 'Delivered'),
    ]

    order_notes = models.TextField(blank=True, null=True)
    status = models.CharField(max_length=50, choices=STATUS_CHOICES, default='processing')
    customer = models.ForeignKey(
        UserModel,
        on_delete=models.CASCADE, 
        related_name='orders',
        null=True,
        blank=True
    )
    billing_details = models.OneToOneField(
        UserProfileModel, 
        on_delete=models.CASCADE, 
        related_name='order',
    )
    
    def __str__(self):
        return f"Order #{self.id} by {self.customer.email}"
    
    def save(self, *args, **kwargs):
        if self.pk:
            old_status = Order.objects.get(pk=self.pk).status
            if old_status != self.status:
                send_order_status_email(
                    user=self.customer,
                    order=self
                )
            
        super().save(*args, **kwargs)


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
    date = models.DateTimeField(default=get_timenow)
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