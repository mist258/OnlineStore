from django.db.models.signals import pre_save
from django.dispatch import receiver

from apps.orders.models import Order
from apps.orders.services.order_service import get_order_by_id

from core.services.email_service import EmailService

from backend.apps.orders.tasks.order_email_tasks import send_order_status_email
from backend.apps.orders.tasks.order_np_tasks import np_ttn_check_and_update


@receiver(pre_save, sender=Order)
def order_status_change(sender, instance, **kwargs):
    if instance.pk:
        old_status = get_order_by_id(instance.pk).status
        if old_status != instance.status:
            if instance.status != 'received':
                np_ttn_check_and_update.delay(ttn=instance.TTN, order_id=instance.id)

                send_order_status_email.delay(
                    order_id=instance.id,
                    status=instance.status,
                    customer_email=instance.customer.email,
                    first_name=instance.billing_details.first_name,
                    last_name=instance.billing_details.last_name
                )