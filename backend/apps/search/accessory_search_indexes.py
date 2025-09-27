from apps.accessories.models import Accessory

from haystack import indexes


class AccessorySearchIndex(indexes.SearchIndex, indexes.Indexable):
    name = indexes.CharField(document=True, model_attr='name')

    def get_model(self):
        return Accessory