from django.db import models

from apps.customer.models import Customer
from apps.order.models import Order


class BillingDetails(models.Model):

    class Meta:
        db_table = "billing_details"
        ordering = ("id",)

    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    company_name = models.CharField(max_length=255, blank=True, null=True)
    province = models.CharField(max_length=100)
    city = models.CharField(max_length=255)
    address_1 = models.CharField(max_length=100, blank=True, null=True)
    address_2 = models.CharField(max_length=100, blank=True, null=True)
    zip_code = models.CharField(max_length=100)
    phone = models.CharField(max_length=20)
    is_configuration = models.BooleanField(default=False)
    order = models.OneToOneField(Order, on_delete=models.CASCADE, related_name='billing_details', null=True,
                                 blank=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='billing_details', null=True)

    def __str__(self):
        return f"Billing for {self.first_name} {self.last_name}"

