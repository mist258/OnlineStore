from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.db import models
from django.db.models import CheckConstraint, Q
from django.utils import timezone

from apps.basket.models import DiscountCode
from apps.products.models import Accessory, Product
from apps.supplies.models import Supply
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
    updated_at = models.DateTimeField(auto_now=True)
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
    first_name = models.CharField(max_length=100, default="Smith")
    last_name = models.CharField(max_length=100, default="John")
    company_name = models.CharField(max_length=255, blank=True, null=True, default="Microsoft")
    country = models.CharField(max_length=100, default="Ukraine")
    state = models.CharField(max_length=100, blank=True, null=True, default="Odessa")
    region = models.CharField(max_length=100, blank=True, null=True, default="Odessa Region")
    street_name = models.CharField(max_length=255, blank=True, null=True, default="Champagne Lane")
    apartment_number = models.CharField(max_length=50, blank=True, null=True, default="7")
    zip_code = models.CharField(max_length=20, blank=True, null=True, default="65063")
    phone_number = models.CharField(max_length=30, default="380991112233")

    # =========================

    def __str__(self):
        customer_email = self.customer.email if self.customer else "No customer"
        return f"Order #{self.id} ({customer_email})"
    
    def get_order_amount(self):
        total = sum(position.evaluate_total_price for position in self.positions.all()) * (1 - (self.discount_code.discount_percent / 100) if self.discount_code else 1)

        return total

    
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

    price = models.DecimalField(
        max_digits=8, 
        decimal_places=2,
        default=0.00,
    )
    quantity = models.IntegerField(default=1)
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

    @property
    def evaluate_total_price(self):
        """Calculate total price for this position using stored price"""
        return self.price * self.quantity