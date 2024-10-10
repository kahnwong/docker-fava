# adapted from https://github.com/beancount/fava/blob/main/contrib/docker/Dockerfile
# gunicorn ref: https://flask.palletsprojects.com/en/1.1.x/deploying/wsgi-standalone/#gunicorn

FROM python:3.13-alpine as builder

RUN apk add --update libxml2-dev libxslt-dev gcc musl-dev g++
COPY requirements.txt requirements.txt
RUN pip install --prefix="/install" -r requirements.txt

FROM python:3.13-alpine

COPY --from=builder /install /usr/local

WORKDIR /opt/app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 5000
ENTRYPOINT ["sh", "entrypoint.sh"]
