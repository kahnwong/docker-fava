FROM python:3.12-slim-bookworm
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

ENV PATH=/root/.local/bin:$PATH
ADD requirements.txt .
RUN uv tool install $(cat requirements.txt | xargs echo)

WORKDIR /opt/app
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 5000
ENTRYPOINT ["sh", "entrypoint.sh"]
