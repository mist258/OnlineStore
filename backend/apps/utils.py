from datetime import datetime


def get_timenow():
    return f'default_{datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}'