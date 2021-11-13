#!/bin/bash


python manage.py migrate --noinput || exit 1
nohup python manage.py startjobs  || exit 1
python manage.py runserver 0.0.0.0:8000