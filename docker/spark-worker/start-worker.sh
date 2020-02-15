#!/usr/bin/env bash

export SPARK_HOME=/usr/lib/spark
export PATH=$PATH:$SPARK_HOME/bin

cd $SPARK_HOME

. "./sbin/spark-config.sh"
. "./bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker.out

/usr/lib/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out
###!/bin/bash

exec "$@"
