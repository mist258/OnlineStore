import os

from django.contrib.auth import get_user_model

from core.exceptions.template_exception import TemplateException
from core.services.jwt_services import JWTService, RecoveryToken

from configs import settings
from mailjet_rest import Client

UserModel = get_user_model()

api_key = os.environ.get("MAILJET_API_KEY")
secret_key = os.environ.get("MAILJET_API_SECRET")


class SendEmail:

    @staticmethod
    def __send_mailjet_email(to_email: str, subject: str, variables: dict, template_id: int):

        mailjet = Client(auth=(api_key, secret_key), version='v3.1')

        data = {
            'Messages': [
                {
                    "From": {
                        "Email": os.environ.get("DEFAULT_FROM_EMAIL"),
                        "Name": "Online coffee store - Coffee Lane"
                    },
                    "To": [
                        {
                            "Email": to_email,
                        }
                    ],
                    "TemplateID": template_id,
                    "TemplateLanguage": True,
                    "Subject": subject,
                    "Variables": variables,
                }
            ]
        }
        result = mailjet.send.create(data=data)
        return result.json()

    @classmethod
    def registration_greeting_email(cls, user: UserModel):
        try:
            cls.__send_mailjet_email(
                to_email=user.email,
                subject="Greeting",
                variables={"username": user.profile.first_name},
                template_id=7331750
            )
        except Exception:
            raise TemplateException


    @classmethod
    def profile_update_notification(cls, user: UserModel):
        try:
            cls.__send_mailjet_email(
                to_email=user.email,
                subject="Profile update",
                variables={"username": user.profile.first_name},
                template_id=7332143
            )
        except Exception:
            raise TemplateException

    @classmethod
    def password_reset_request(cls, user: UserModel):
        token = JWTService.create_token(user, RecoveryToken)
        url = f"{settings.FRONTEND_BASE_URL}/recovery_password/{token}"

        try:
            cls.__send_mailjet_email(
                to_email=user.email,
                subject="Password reset request",
                variables={"first_name": user.profile.first_name,
                           "last_name": user.profile.last_name,
                           "url": url},
                template_id=7332227
            )
        except Exception:
            raise TemplateException

    @classmethod
    def change_password_notification(cls, user: UserModel):
        try:
            cls.__send_mailjet_email(
                to_email=user.email,
                subject="Password changed",
                variables={"username": user.profile.first_name},
                template_id=7332377
            )
        except Exception:
            raise TemplateException

    @classmethod
    def order_status_notification(cls, order_id, status, customer_email, first_name, last_name):
        try:
            cls.__send_mailjet_email(
                to_email=customer_email,
                subject="Order status notification",
                variables={"username": f"{first_name} {last_name}",
                           "order_id": order_id,
                           "status": status},
                template_id= 7333085
            )
        except Exception:
            raise TemplateException


    # @classmethod
    # def subscribed_notification(cls, user: UserModel):
    #     try:
    #         cls.__send_mailjet_email(
    #
    #         )
    #     except Exception:
    #         pass
