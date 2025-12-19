from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import models
from django.db.models import CheckConstraint, Q
from django.utils import timezone

from apps.basket.models import DiscountCode
from apps.products.models import Accessory, Product
from apps.users.models import UserProfileModel

from core.services.mailjet_service import SendEmail

UserModel = get_user_model()


class Order(models.Model):

    class Meta:
        db_table = "orders"
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
    )
    ttn = models.CharField(max_length=50, blank=True, null=True)
    created_at = models.DateTimeField(default=timezone.now)
    discount_code = models.ForeignKey(
        DiscountCode,
        on_delete=models.SET_NULL,
        null=True,
        blank=True, 
        related_name="orders"
    )
    
    # =========================
    # Billing details (embedded)
    # =========================
    billing_first_name = models.CharField(max_length=100, default="Smith")
    billing_last_name = models.CharField(max_length=100, default="John")
    billing_company_name = models.CharField(max_length=255, blank=True, null=True, default="Microsoft")

    billing_country = models.CharField(max_length=100, default="Ukraine")
    billing_state = models.CharField(max_length=100, blank=True, null=True, default="Odessa")
    billing_region = models.CharField(max_length=100, blank=True, null=True, default="Odessa Region")

    billing_street_name = models.CharField(max_length=255, blank=True, null=True, default="Champagne Lane")
    billing_apartment_number = models.CharField(max_length=50, blank=True, null=True, default="7")
    billing_zip_code = models.CharField(max_length=20, blank=True, null=True, default="65063")

    billing_phone_number = models.CharField(max_length=30, default="380991112233")
    
    def __str__(self):
        customer_email = self.customer.email if self.customer else "No customer"
        return f"Order #{self.id} ({customer_email})"
    
    def get_order_amount(self):
        total = sum(position.total_price for position in self.positions.all())

        return total
    
    def save(self, *args, **kwargs):
        if self.pk:
            old_status = Order.objects.get(pk=self.pk).status
            if old_status != self.status:
                SendEmail.order_status_notification(
                    order_id=self.id,
                    status=self.status,
                    customer_email=self.customer.email,
                    first_name=self.billing_details.first_name,
                    last_name=self.billing_details.last_name
                )
            
        super().save(*args, **kwargs)

    
class OrderPosition(models.Model):

    class Meta:
        db_table = "order_positions"
        ordering = ("id",)
        constraints = [
            CheckConstraint(
                condition=(
                    (Q(product__isnull=False) & Q(accessory__isnull=True)) |
                    (Q(product__isnull=True) & Q(accessory__isnull=False))
                ),
                name="exactly_one_product_or_accessory"
            )
        ]

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
    
    def clean(self):
        if not self.product and not self.accessory:
            raise ValidationError("Either product or accessory must be set.")
        if self.product and self.accessory:
            raise ValidationError("Only one of product or accessory can be set.")

    def __str__(self):
        product = self.product or self.accessory
        return f"{self.quantity}x {product.name} in Order #{self.order.id}"

