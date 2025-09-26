from haystack import indexes
from models import Accessory


class AccessorySearchIndex(indexes.SearchIndex, indexes.Indexable):
    name = indexes.CharField(document=True, model_attr='name')

    def get_model(self):
        return Accessory