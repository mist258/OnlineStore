from celery import shared_task
from core.services.novaposhta_service import NovaPoshtaService
from apps.orders.services import get_order_by_id

from apps.orders.services import update_order


@shared_task(bind=True, max_retries=3, countdown=43200, retry_backoff=True)
def np_ttn_check_and_update(self, ttn, order_id):
    np = NovaPoshtaService()
    order = get_order_by_id(order_id)
    try:
        request = np.check_ttn(ttn=ttn)
        
        if request.get("success"):
            update_order(order_id=order_id, data=request)
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