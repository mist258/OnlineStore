import os

from django.contrib.auth import get_user_model
from django.core.mail import EmailMultiAlternatives
from django.template.loader import get_template

from core.exceptions.template_exception import TemplateException
from core.services.jwt_services import JWTService, RecoveryToken

from configs import settings
from configs.celery import app

UserModel = get_user_model()

class EmailService:

    @staticmethod
    @app.task
    def __send_email(to: str, template_name: str, context: dict, subject: '') -> None:
        template = get_template(template_name)
        html_content = template.render(context)
        msg = EmailMultiAlternatives(subject=subject, from_email=os.environ.get("EMAIL_HOST_USER"), to=[to])
        msg.attach_alternative(html_content, "text/html")
        msg.send()

    @classmethod
    def send_recovery_email(cls, user: UserModel):

        token = JWTService.create_token(user, RecoveryToken)
        url = f"{settings.FRONTEND_BASE_URL}/recovery_password/{token}"

        try:
            cls.__send_email.delay(user.email,
                             "recovery.html",
                             {
                                 "first_name": user.profile.first_name,
                                 "last_name": user.profile.last_name,
                                 "url": url
                             },
                             "Recovery password")
        except Exception:
            raise TemplateException

    @classmethod
    def greeting_registration_email(cls, user: UserModel):

        try:
            cls.__send_email.delay(user.email,
                                   "registration_greeting.html",
                                   {
                                       "first_name": user.profile.first_name,

                                   },
                                   "Registration greeting"
                                   )
        except Exception:
            raise TemplateException

    @classmethod
    def password_changed_notification_email(cls, user: UserModel):

        try:
            cls.__send_email.delay(user.email,
                                   "password_changed.html",
                                   {
                                       "first_name": user.profile.first_name,
                                   },
                                   "Password has been successfully changed"
                                   )
        except Exception:
            raise TemplateException

    @classmethod
    def updated_info_notification_email(cls, user: UserModel):

        try:
            cls.__send_email.delay(user.email,
                                   "update_info.html",
                                   {
                                       "first_name": user.profile.first_name,
                                   },
                                   "Profile data has been successfully updated")
        except Exception:
            raise TemplateException

    @classmethod
    def send_order_status_email(cls, order_id, status, customer_email, first_name, last_name):
        try:
            cls.__send_email.delay(
                customer_email,
                "order_status.html",
                {
                    "order_id": order_id,
                    "status": status,
                    "customer_name": f"{first_name} {last_name}"
                },
                f"Order #{order_id} status update"
            )
        except Exception:
            raise TemplateException
