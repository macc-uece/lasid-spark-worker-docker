#!/bin/bash

SPARK_VER="2.4.6"
UBUNTU_VER="_bionic"

set -e

## Build Docker image
docker build -t lasid/spark-base -t lasid/spark-base:$SPARK_VER$UBUNTU_VER ./docker/spark-base
docker build -t lasid/spark-worker -t lasid/spark-worker:$SPARK_VER$UBUNTU_VER ./docker/spark-worker
docker build -t lasid/spark-worker-tensorflow -t lasid/spark-worker-tensorflow:$SPARK_VER$UBUNTU_VER ./docker/spark-worker-tensorflow
#docker build -t lasid/spark-worker-mesos:latest ./docker/spark-worker-mesos

## Push image to DockerHub
docker login
#docker push lasid/spark-worker:latest
docker push lasid/spark-worker:$SPARK_VER$UBUNTU_VER
docker push lasid/spark-worker-tensorflow:latest
docker push lasid/spark-worker-tensorflow:$SPARK_VER$UBUNTU_VER
#docker push lasid/spark-worker-mesos:latest
