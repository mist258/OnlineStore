from core.services.email_service import EmailService

from celery import shared_task


@shared_task(bind=True, max_retries=3, retry_backoff=True)
def send_order_status_email(self, order_id, status, customer_email, first_name, last_name):
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