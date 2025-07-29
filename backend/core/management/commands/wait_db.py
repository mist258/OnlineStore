import time

from django.core.management import BaseCommand
from django.db import OperationalError, connection
from django.db.backends.postgresql.base import DatabaseWrapper

connection: DatabaseWrapper = connection


class Command(BaseCommand):
    def handle(self, *args, **options):
        self.stdout.write("Waiting for database...")
        con_db = False

        while not con_db:
            try:
                connection.ensure_connection()
                con_db = True
            except OperationalError:
                self.stdout.write("Waiting for database...")
                time.sleep(3)

        self.stdout.write("Database connection established")
