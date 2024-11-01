FROM python:3.12-slim-bookworm
# hadolint ignore=DL3045
COPY requirements.txt .
RUN pip install -r requirements.txt --no-cache-dir

WORKDIR /opt/app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 5000
ENTRYPOINT ["sh", "entrypoint.sh"]
