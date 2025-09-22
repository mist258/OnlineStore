# Coffee shop
**Python version** - 3.12

**Database** - PostgreSQL (Supabase)

**Deployment** - Render (https://onlinestore-928b.onrender.com/api/doc)


## Already added to the project
 
✔️ *poetry* 

✔️ *docker*

✔️ *isort* (for managing and sorting imports)

✔️ *ruff* (linter)

✔️ *pillow* (photo managing)
  
✔️ *django-filter* (filtering requests)

✔️ *gunicorn* (for deploying on render)

✔️ *celery + redis* (perform tasks in the background)

✔️ *drf-yasg* (documentation)

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

**/api/users/info** - authenticated user can get own info (display profile and oreder information)

**/api/users/list/** - superuser/admin can list all users

**/api/users/list/<int:pk>** - superuser/admin can retrieve user by ID

**/api/users/avatars** - admin or regular user can add avatar to profile (for authenticated users)

**/api/users/autofill_form** - display user's profile information to autofill form's fields when user place an order

## products

**/api/products** - display a list of all coffee products (for anyone)

**/api/products/<int:pk>** - display a specific product by its ID (for anyone)

**/api/products/product** - create a new product (only for superuser)

**/api/products/product/<int:pk>** -  full/partial update product by  its ID  (only for superuser)

**/api/products/<int:pk>/deletion** - deletes a specific product by its ID (only for superuser)

**/api/products/<int:pk>/photo** - add photo (from local machine) to the product by its ID (only for superuser)

**/api/products/photo/<int:pk>/deletion** - delete photo from product by its ID (only for superuser)

**/api/products/search** - searching for a query for two models Product & Accessory (for anyone)


## supplies

**/api/supplies/products/<int:pk>** - add supplies to specific product by its ID  (only for superuser)

**/api/supplies/<int:pk>** - update or delete or partial update a specific supplies by its ID (only for superuser)


## orders

**/api/order/create** - user can place an order (for anyone)

**/api/order/list** -  admin can list all orders (for superuser)

**/api/order/track-ttn/** - user can track ttn (for authemticated users)


## accessories

**/api/accessories** - display a list of all accessories (for anyone)

**/api/accessories/<int:pk>** - display a specific accessories by its ID (for anyone)

**/api/accessories/new_accessory** -  add new accessory (only for superuser)

**/api/accessories/<int:pk>/photo** - add photo to accessory (only for superuser)

**/api/accessories/<int:pk>/remove_photo** - remove photo from accessory (only for superuser)



## Installation

Install project 

```bash
  https://github.com/mist258/OnlineStore

  poetry install

  docker compose up --build 

  docker compose run --rm app sh

 ./manage.py makemigrations
 ./manage.py migrate
 ./manage.py createsuperuser


```

**Note:** Before executing command `poetry install` you should follow the next steps:

Settings -> python interpreter -> add interpreter -> 
add local interpreter -> type: Poetry & Base Python: Python 3.12

