from datetime import datetime

from django.db import models


def get_timenow():
    return f'default_{datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}'


class FlavorProfile(models.Model):
    name = models.CharField(max_length=100, null=False, unique=True)

    def __str__(self):
        return self.name


class Product(models.Model):
    sku = models.CharField(max_length=50, unique=True, null=False)
    name = models.CharField(max_length=255, null=False)
    brend = models.CharField(max_length=255, null=False)
    caffeine_type = models.CharField(max_length=25, blank=True, null=False)
    sort = models.CharField(max_length=25, null=False, blank=True)
    roast = models.CharField(max_length=50)
    description = models.TextField(blank=True, null=False)

    flavor_profiles = models.ManyToManyField(
        FlavorProfile, 
        related_name='products', blank=True
    )

    def __str__(self):
        return self.name


class Supply(models.Model):
    serving_type = models.CharField(max_length=50, blank=True, null=False)
    price = models.DecimalField(
        max_digits=8, 
        decimal_places=2, 
        default=0.00, 
        null=True
    )
    weight = models.DecimalField(
        max_digits=5, 
        decimal_places=2, 
        blank=True, 
        null=True
    )
    quantity = models.IntegerField(default=0)
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE, 
        related_name='supplies'
    )

    def __str__(self):
        return f"{self.product.name} - {self.serving_type or 'No Serving-Type Info'}"


class Photo(models.Model):
    filename = models.CharField(
        max_length=255, 
        null=True, 
        default=get_timenow
    )
    position = models.IntegerField(default=0)
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE, 
        related_name='photos'
    )

    def __str__(self):
        return f"{self.filename} (Product: {self.product.name})"


class Subscription(models.Model):
    name = models.CharField(max_length=100)
    letter = models.CharField(max_length=100)

    def __str__(self):
        return self.name


class Customer(models.Model):
    email = models.CharField(max_length=100, unique=True)
    password = models.CharField(max_length=255, blank=True, null=True)
    is_guest = models.BooleanField(default=True)

    subscriptions = models.ManyToManyField(
        Subscription, 
        related_name='customers', 
        blank=True
    )

    def __str__(self):
        return self.email


class Review(models.Model):
    grade = models.IntegerField()
    date = models.DateField(default=get_timenow)
    comment = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        Customer, 
        on_delete=models.CASCADE, 
        related_name='reviews'
    )
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE, 
        related_name='reviews'
    )

    def __str__(self):
        return f"Review {self.grade}★ by {self.customer.email}"


class Order(models.Model):
    order_notes = models.TextField(blank=True, null=True)
    customer = models.ForeignKey(
        Customer, 
        on_delete=models.CASCADE, 
        related_name='orders'
    )

    def __str__(self):
        return f"Order #{self.id} by {self.customer.email}"


class OrderPosition(models.Model):
    quantity = models.IntegerField(default=1)
    product = models.ForeignKey(
        Product, 
        on_delete=models.CASCADE, 
        related_name='order_positions'
    )
    order = models.ForeignKey(
        Order, 
        on_delete=models.CASCADE, 
        related_name='positions'
    )

    def __str__(self):
        return f"{self.quantity}x {self.product.name} in Order #{self.order.id}"
    

class BillingDetails(models.Model):
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
    order = models.OneToOneField(Order, on_delete=models.CASCADE, related_name='billing_details', null=True, blank=True)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE, related_name='billing_details', null=True)

    def __str__(self):
        return f"Billing for {self.first_name} {self.last_name}"
