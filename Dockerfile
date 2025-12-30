FROM ghcr.io/astral-sh/uv:bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 UV_LINK_MODE=copy
ENV UV_PYTHON_INSTALL_DIR=/python
ENV UV_PYTHON_PREFERENCE=only-managed
RUN uv python install 3.13

WORKDIR /app

# hadolint ignore=DL3045
COPY requirements.txt .
RUN uv venv && uv pip install -r requirements.txt --no-cache-dir

FROM gcr.io/distroless/cc:debug

COPY --from=builder --chown=python:python /python /python

WORKDIR /app
COPY --from=builder --chown=app:app /app/.venv /app/.venv

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 5000
ENTRYPOINT ["fava", "--host", "0.0.0.0", "/opt/fava/main.bean"]
