from django.db import models


class InitialTest(models.Model):
    class Meta:
        db_table = 'initial_test'
        ordering = ['id']

    any_text = models.TextField(max_length=25)