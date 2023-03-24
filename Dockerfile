FROM python:3.8-slim-bullseye

WORKDIR /app

# Install build tool
ARG POETRY_VERSION="1.4.1"
RUN python -m pip install --upgrade pip poetry==${POETRY_VERSION} && \
    poetry config virtualenvs.create false

# Install OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
 	python-dev \
    libglpk-dev && \
    rm -rf /var/lib/apt/lists/*

COPY pyproject.toml .
COPY poetry.lock .

RUN poetry install

COPY . .
