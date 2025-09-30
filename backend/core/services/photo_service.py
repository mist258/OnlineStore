import os
from uuid import uuid1

from core.exceptions.photo_extension_exception import PhotoExtensionException


class PhotoService:

    @staticmethod
    def upload_product_photo(instance, file: str) -> str:
        extension = file.split('.')[-1]

        if extension not in ['jpg', 'jpeg', 'png']:
            raise PhotoExtensionException

        return os.path.join('upload_photos', f'{uuid1()}.{extension}')

    @staticmethod
    def upload_avatar(instance, file: str) -> str:
        extension = file.split('.')[-1]

        if extension not in ['jpg', 'jpeg', 'png']:
            raise PhotoExtensionException
        return os.path.join('avatars', f'{uuid1()}.{extension}')
