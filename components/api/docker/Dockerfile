ARG PYTHON_BASE_IMAGE
ARG DATAVISYN_PYTHON_BASE_IMAGE
## ################################################################
## Base Image
## ################################################################
FROM ${PYTHON_BASE_IMAGE} as python-base

ARG GIT_ACCESS_TOKEN

ENV VIRTUAL_ENV=/opt/venv

# install common packages to compile python
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends git libpq-dev gcc libxrender1 linux-libc-dev libc6-dev libsm6 libxext6 libxrender-dev libbz2-dev \
    ## cleanup
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove --purge  -y \
    && rm -rf /var/lib/apt/lists/*

## Git config
RUN git config --global url."https://${GIT_ACCESS_TOKEN}@github".insteadOf "https://github" \
    && git config --global --add url."https://${GIT_ACCESS_TOKEN}@github.com".insteadOf "ssh://git@github.com" \
    ## Add venv
    && python -m venv "$VIRTUAL_ENV"

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

## Install python packages
## Option 1: single app with wheels
# COPY ./dist_python/ /app/visyn/wheels
# RUN python3 -m pip install --upgrade --no-cache-dir pip \
#     && python3 -m pip install --no-cache-dir wheel \
#     && python3 -m pip install  --disable-pip-version-check --no-cache-dir /app/visyn/wheels/*  \
#     && ls -lah /opt/venv && ls -lah /opt/venv/lib/python3.10/site-packages

## Option 2: workspace app
COPY requirements.txt /app/visyn/
RUN python3 -m pip install --upgrade --no-cache-dir pip wheel \
    && python3 -m pip install  --disable-pip-version-check --no-cache-dir -r /app/visyn/requirements.txt  \
    && ls -lah /opt/venv && ls -lah /opt/venv/lib/python3.10/site-packages

## ################################################################
## Final Stage
## ################################################################
FROM ${DATAVISYN_PYTHON_BASE_IMAGE}

WORKDIR /app/visyn

COPY --from=python-base /lib/x86_64-linux-gnu/lib* /usr/lib/x86_64-linux-gnu/
COPY --from=python-base /opt/venv /opt/venv
## Option 2: workspace app
COPY ./build/source ./