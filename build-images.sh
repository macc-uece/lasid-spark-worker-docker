#!/bin/bash

set -e

docker build -t lasid/spark-base:latest ./docker/spark-base
docker build -t lasid/spark-worker:latest ./docker/spark-worker
#docker build -t lasid/spark-worker-mesos:latest ./docker/spark-worker-mesos
docker login
docker push lasid/spark-worker:latest
#docker push lasid/spark-worker-mesos:latest
