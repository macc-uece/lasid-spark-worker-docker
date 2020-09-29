#!/bin/bash

if [  $# -lt 1 ] || [  $# -gt 2 ] || [  $1 == '-h' ] || [  $1 == '--help' ]
then
	echo "Script to build LASID Spark Docker image."
  echo "Usage: ./build-images.sh [-h] <Spark> " 
  echo "  <Spark> Spark number version, i.e.,  2.4.5 
  echo "  -h      Display this help message"
	exit 1
fi

SPARK_VER=$1
UBUNTU_VER="bionic"

set -e

## Build Docker image
docker build --build-arg SPARK_VER -t lasid/spark-base -t lasid/spark-base:${SPARK_VER}_${UBUNTU_VER} ./docker/spark-base
docker build --build-arg SPARK_VER -t lasid/spark-worker -t lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER} ./docker/spark-worker
docker build --build-arg SPARK_VER -t lasid/spark-worker-tensorflow -t lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER} ./docker/spark-worker-tensorflow

## Push image to DockerHub
docker login
#docker push lasid/spark-worker:latest
docker push lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}
#docker push lasid/spark-worker-tensorflow:latest
docker push lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}
