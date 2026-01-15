from decimal import Decimal

from django.core.cache import cache

import requests


class CurrencyService:
    CACHE_KEY = 'privatbank_rates'
    REQUEST_URL = 'https://api.privatbank.ua/p24api/pubinfo?exchange&json&coursid=11'
    CACHE_TIMEOUT = 60 * 30

    @classmethod
    def get_exchange_rates(cls):

        cached = cache.get(cls.CACHE_KEY)
        if cached:
            return cached

        res = requests.get(cls.REQUEST_URL, timeout=5)
        res.raise_for_status()
        data = res.json()
        rates = {}

        for item in data:
            if item['ccy'] in ('USD', 'EUR'):
                rates[item['ccy']] = Decimal(item['sale'])

        cache.set(cls.CACHE_KEY, rates, cls.CACHE_TIMEOUT)
        return rates


    @classmethod
    def convert(cls, price_usd: Decimal, to_currency: str) -> Decimal:

        rates = CurrencyService.get_exchange_rates()

        if to_currency == 'USD':
            return price_usd

        usd_to_uah = rates.get('USD')
        eur_to_uah = rates.get('EUR')

        if not usd_to_uah:
            raise ValueError('USD rate missing')

        if to_currency == 'UAH':
            return (price_usd * usd_to_uah).quantize(Decimal('0.01'))

        if to_currency == 'EUR':
            if not eur_to_uah:
                raise ValueError('EUR rate missing')

            return (
                price_usd * usd_to_uah / eur_to_uah
            ).quantize(Decimal('0.01'))

        raise ValueError('Unsupported currency %s')



