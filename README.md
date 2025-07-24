# Coffee shop
**Python version** - 3.12

**Database** - PostgreSQL (Supabase)
**Deployment** - Render


## Already added to the project
 
✔️ *poetry* (instead of .venv & .requirements.txt)

✔️ *docker*

✔️ *isort* (for managing and sorting imports)

✔️ *ruff* (linter)

✔️ *pillow* (photo managing)
  
✔️ *django-filter* (filtering requests)

✔️ *joined pagination* (DEFAULT_PAGINATION_CLASS)
  
✔️ *joined filters* (DEFAULT_FILTER_BACKENDS)

✔️ *gunicorn* (for deploying on render)

✔️ *celery + redis* (perform tasks in the background)

✔️ *drf-yasg* (documentation)

✔️ *django_countries* (provides fixed list of countries)

✔️ *whitenoise* (serving static files without using a separate web server (Nginx),
this needed to display the documentation on 'Render')

✔️ *djangorestframework-simplejwt* (authentication by JWT)

✔️ *psycopg2-binary* (need to connect supabase with drf)

✔️ *google-auth* (need for oAuth)

# ENDPOINTS

## auth

**/api/auth/login** - login for registered users

**/api/auth/refresh** - create new refresh and access tokens

**/api/auth/logout** - logout for authenticated users

**/api/auth/recovery_request** - send request to change password

**/api/auth/recovery_password/<str:token>** - changing password 


## oauth_google

**/api/oauth_google** - auth user from Google


## users

**/api/users** - register new user

**/api/users/info** - authenticated user can get own info

**/api/users/list/** - superuser/admin can list all users

**/api/users/list/<int:pk>** - superuser/admin can retrieve user


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

