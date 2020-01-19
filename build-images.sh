#!/bin/bash

set -e

docker build -t lasid/spark-base:latest ./docker/spark-base
docker build -t lasid/spark-worker:latest ./docker/spark-worker
