from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import exception_handler


def error_handler(exc: Exception, context:dict) -> Response:
    handlers = {
        "JWTException": _jwt_validation_exception_handler,
        "TemplateException": _template_validation_exception_handler,
        "GoogleTokenException": _google_token_exception_handler,

    }

    response = exception_handler(exc, context)
    exc_class = exc.__class__.__name__

    if exc_class in handlers:
        return handlers[exc_class](exc, context)

    return response

def _jwt_validation_exception_handler(exc: Exception, context:dict) -> Response:
    return Response(
        {"Detail": "Token is invalid or expired"},
            status.HTTP_400_BAD_REQUEST,)

def _template_validation_exception_handler(exc: Exception, context:dict) -> Response:
    return Response(
        {"Detail": "Template is invalid or doesn't exist"},
            status.HTTP_422_UNPROCESSABLE_ENTITY,)

def _google_token_exception_handler(exc: Exception, context:dict) -> Response:

    return Response(
        {"Detail": "Google Token is invalid or expired"},
        status.HTTP_401_UNAUTHORIZED,
    )


