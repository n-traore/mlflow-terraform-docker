ARG PYTHON_VERSION=3.11
ARG DEBIAN_BASE=bookworm
FROM python:${PYTHON_VERSION}-slim-${DEBIAN_BASE}

ARG MLFLOW_VERSION=2.15.1
ENV PYTHONUNBUFFERED 1

WORKDIR /tracking-srv

RUN pip install --no-cache mlflow==${MLFLOW_VERSION} cryptography boto3 psycopg2-binary
