# pull the official base image
FROM python:3.9-buster

RUN apt-get update && apt-get install nginx -y --no-install-recommends
COPY nginx.default /etc/nginx/sites-available/default
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN  pip install --upgrade pip 
COPY . /usr/src/app
RUN pip install -r requirements.txt

EXPOSE 8000

CMD ["sh", "/usr/src/app/entrypoint.sh"]