# Build Tensorflow Docker Worker
ARG UBUNTU_VERSION=18.04

FROM ubuntu:${UBUNTU_VERSION} as base

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"
LABEL version="0.4"

ENV LANG C.UTF-8

RUN apt-get update && apt-get upgrade -y && apt-get install -y curl

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools

# Some TF tools expect a "python" binary
RUN ln -s $(which python3) /usr/local/bin/python

# Installs the latest version by default.
# Options:
#   tensorflow
#   tensorflow-gpu
ARG TF_PACKAGE=tensorflow
ARG TF_PACKAGE_VERSION=
RUN python3 -m pip install --no-cache-dir ${TF_PACKAGE}${TF_PACKAGE_VERSION:+==${TF_PACKAGE_VERSION}}
RUN python3 -m pip install --no-cache-dir tensorflowonspark

EXPOSE 8080 8081 8082 8083 8084

