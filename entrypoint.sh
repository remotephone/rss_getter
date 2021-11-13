#!/bin/bash

#!/usr/bin/env bash
# start-server.sh
python manage.py migrate --noinput
(cd /usr/src/app; gunicorn content_aggregator.wsgi --user www-data --bind 0.0.0.0:8000 --workers 3) &
nginx -g "daemon off;"

