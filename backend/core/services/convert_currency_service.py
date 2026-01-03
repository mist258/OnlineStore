from decimal import Decimal

import requests


class CurrencyService:

    @staticmethod
    def get_exchange_rates():
        res = requests.get('https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11')

        try:
            if res.status_code == 200:
                data = res.json()
                return data

        except Exception as e:
            return e

