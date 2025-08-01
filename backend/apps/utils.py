from datetime import datetime


def get_timenow():
    return f'{datetime.now().strftime("%Y-%m-%dT%H:%M:%S")}'