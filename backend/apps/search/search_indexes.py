from apps.accessories.models import Accessory
from apps.products.models import Product

from haystack import indexes


class AccessorySearchIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.EdgeNgramField(document=True,
                                       model_attr='name',
                                       null=True)
    type = indexes.CharField()

    def get_model(self):
        return Accessory

    def prepare_type(self, obj):
        return 'accessory'

    def index_queryset(self, using=None):
        return self.get_model().objects.all()


class ProductSearchIndex(indexes.SearchIndex, indexes.Indexable):
    text = indexes.EdgeNgramField(document=True,
                                       model_attr='name',
                                       null=True)
    type = indexes.CharField()

    def get_model(self):
        return Product

    def prepare_type(self, obj):
        return 'product'

    def index_queryset(self, using=None):
        return self.get_model().objects.all()
