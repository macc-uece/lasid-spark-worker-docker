#!/bin/bash

####!/usr/bin/env bash

. "./sbin/spark-config.sh"
. "./bin/load-spark-env.sh"

export SPARKMASTER=${SPARKMASTER:-"mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"}
export MESOSEXECUTORCORE=${MESOSEXECUTORCORE:-0.1}
#export SPARKIMAGE=${SPARKIMAGE:-"lasid/spark-worker:latest"}
export CURRENTIP=$(hostname -i)
export SPARK_WORKER_LOG=${SPARK_WORKER_LOG:-"/var/log/spark"}
export SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT:-"8081"}
#export SPARKLOCALIP=${SPARKLOCALIP:-${CURRENTIP:-"127.0.0.1"}}
#export SPARKPUBLICDNS=${SPARKPUBLICDNS:-${CURRENTIP:-"127.0.0.1"}}
export SPARK_HOME=${SPARK_HOME:-"/usr/lib/spark"}
export PATH=$PATH:$SPARK_HOME/bin

cd $SPARK_HOME

#exec "$@"

mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker-$CURRENTIP.out

/usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out
