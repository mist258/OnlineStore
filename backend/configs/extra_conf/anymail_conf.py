import os

ANYMAIL = {
    "MAILERSEND": os.environ.get("MAILERSEND_API_TOKEN"),
}

EMAIL_BACKEND = "anymail.backends.mailersend.EmailBackend"
DEFAULT_FROM_EMAIL=os.environ.get('DEFAULT_FROM_EMAIL')
SERVER_EMAIL=os.environ.get('SERVER_EMAIL')
