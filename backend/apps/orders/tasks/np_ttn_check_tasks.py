from celery import shared_task
from django.conf import settings
from core.services.novaposhta_service import NovaPoshtaService
from core.services.email_service import EmailService
from apps.orders.services import get_order_by_id

from apps.orders.services import update_order


@shared_task(bind=True, max_retries=3, countdown=43200, retry_backoff=True)
def np_ttn_check_and_update(self, ttn, order_id):
    np = NovaPoshtaService(api_key=settings.NOVA_POSHTA_API_KEY)
    order = get_order_by_id(order_id)
    try:
        request = np.check_ttn(ttn=ttn)
        
        if request.get("success"):
            update_order(order_id=order_id, status=request.get("status"))
            order.ttn = request.get("ttn")
            order.save()
            return request
        
        raise Exception("Failed to get successful response from Nova Poshta")
    
    except Exception as exc:
        try:
            self.retry(exc=exc)
        except self.MaxRetriesExceededError:
            update_order(order_id=order_id, status="failed")
            return False


@shared_task(bind=True, max_retries=3, retry_backoff=True)
def send_order_email(self, order_id, status, customer_email, first_name, last_name):
    try:
        EmailService.send_order_status_email(
            order_id=order_id,
            status=status,
            customer_email=customer_email,
            first_name=first_name,
            last_name=last_name
        )
    except Exception as exc:
        try:
            self.retry(exc=exc)
        except self.MaxRetriesExceededError:
            return False