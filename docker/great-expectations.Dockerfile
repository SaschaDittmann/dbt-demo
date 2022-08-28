FROM python:3.10.6-slim-bullseye

RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

# Env vars
ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN python3 -m pip install --upgrade pip setuptools wheel --no-cache-dir

RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    python-dev \
    libsasl2-dev \
    gcc \
    unixodbc-dev \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

RUN python3 -m pip install --no-cache great_expectations sqlalchemy sqlalchemy-bigquery pyodbc

WORKDIR /usr/app/great_expectations/
VOLUME /usr/app
ENTRYPOINT ["great_expectations"]
