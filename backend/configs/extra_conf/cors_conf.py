import os

CORS_ALLOWED_ORIGINS = [
    "http://localhost:3000",
    "http://localhost:5173",
    "https://coffe-shop-frontend-six.vercel.app",
]

FRONTEND_BASE_URL = (
    os.getenv("FRONTEND_DEV") or
    os.getenv("FRONTEND_VERCEL") or
    "http://localhost:3000"
)

if FRONTEND_BASE_URL not in CORS_ALLOWED_ORIGINS:
    FRONTEND_BASE_URL = "http://localhost:3000"
