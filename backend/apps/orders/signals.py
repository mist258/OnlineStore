from apps.orders.services import get_order_by_id

from django.dispatch import receiver
from django.db.models.signals import pre_save
from core.services.email_service import EmailService
from apps.orders.tasks.np_ttn_check_tasks import np_ttn_check_and_update, send_order_status_email


@receiver(pre_save, sender=Order)
def order_status_change(sender, instance, **kwargs):
    if instance.pk:
        old_status = get_order_by_id(instance.pk).status
        if old_status != instance.status:
            if instance.status != 'delivered':
                np_ttn_check_and_update.delay(ttn=instance.TTN, order_id=instance.id)
            
            send_order_status_email.delay(
                order_id=instance.id,
                status=instance.status,
                customer_email=instance.customer.email,
                first_name=instance.billing_details.first_name,
                last_name=instance.billing_details.last_name
            )