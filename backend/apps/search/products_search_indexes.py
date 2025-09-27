from haystack import indexes

from .models import Product


class ProductSearchIndex(indexes.SearchIndex, indexes.Indexable):
    name = indexes.CharField(document=True, model_attr='name')

    def get_model(self):
        return Product
