from django.db.models import Manager


class ProductAccessoryManager(Manager):

    def global_search(self, query: str):
        queryset = self.get_queryset()

        if query:
            data = ...