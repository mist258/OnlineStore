from django.db import models

from cloudinary.models import CloudinaryField


class InitialTest(models.Model):
    class Meta:
        db_table = 'initial_test'
        ordering = ['id']

    any_text = models.TextField(max_length=25)
    photo = CloudinaryField('image')
