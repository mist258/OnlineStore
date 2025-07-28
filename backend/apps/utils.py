from datetime import datetime


def default_photo_url():
    return f"default_{datetime.now().isoformat()}"