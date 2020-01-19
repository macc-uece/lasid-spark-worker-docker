#!/bin/bash

set -e

docker build -t spark-base:latest ./docker/spark-base
docker build -t spark-worker:latest ./docker/spark-worker
