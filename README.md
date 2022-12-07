# Ecom-Mobile-App
## Backend system config

### Install prequisites
* **To run this Project, Python3, pip and MySQL is required.**

* To install Python Pip packages to run the backend server, you can use any virtual enviroment manager as you prefer.

```
# example of virtualenv
virtualenv env

source env/bin/activate

pip install -r requirements.txt
```

### Database config
* After install the environment, we need to config the settings to run on local Database, the setting could be found on EcomApp/EcomApp/settings.py

* Find this segment of code and change it to your MySQL database setting

```
...

# TODO: Change this to your own DB schema in MySQL
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'ecom',
        'USER': 'root',
        'PASSWORD': 'c@ncEll3r',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

...
```
* After change the server database settings, we can now make migration to the database by running:
```
# Migrate the Django services' data to the database

python manage.py migrate
```

* Then, we can begin to run the *scripts.sql* file in the database to create the Tables for our system.

* To create the models according to the table for later uses in development process, run:
```
python manage.py inspectdb > base/models.py
```

* To run the system, run:
```
# This step is optional, but you should have at least 1 superuser account to have access to the Django administrator service

python manage.py createsuperuser

# Run the system 

python manage.py runserver
```