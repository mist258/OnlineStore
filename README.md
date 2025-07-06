# Coffee shop
**Python version** - 3.12

**Database** - PostgreSQL

App **'initial'** - is test app, during development will be deleted.


## Already added to the project
 
✔️ poetry (instead of .venv & .requirements.txt)

✔️ docker

✔️ nginx (for proxying requests but can be removed)

✔️ isort (for managing and sorting imports)

✔️ ruff (linter)

✔️ pillow (photo managing)
  
✔️ django-filter (filtering requests)

✔️ joined pagination (DEFAULT_PAGINATION_CLASS)
  
✔️ joined filters (DEFAULT_FILTER_BACKENDS)

## Installation

Install project 

```bash
  https://github.com/mist258/OnlineStore

  poetry install

  docker compose up --build 

  docker compose run --rm app sh

 ./manage.py makemigrations
 ./manage.py migrate

```

**Note:** Before executing command `poetry install` you should follow the next steps:

Settings -> python interpreter -> add interpreter -> 
add local interpreter -> type: Poetry & Base Python: Python 3.12

