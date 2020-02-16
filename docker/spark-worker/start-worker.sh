#!/usr/bin/env bash

SPARKMASTER=${SPARKMASTER:-"mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"}
MESOSEXECUTORCORE=${MESOSEXECUTORCORE:-0.1}
SPARKIMAGE=${SPARKIMAGE:-"lasid/spark-worker:latest"}
CURRENTIP=$(hostname -i)
SPARK_WORKER_LOG=${SPARK_WORKER_LOG:-"/var/log/spark"}

sed -i 's;SPARKMASTER;'$SPARKMASTER';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;MESOSEXECUTORCORE;'$MESOSEXECUTORCORE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;SPARKIMAGE;'$SPARKIMAGE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;CURRENTIP;'$CURRENTIP';g' /usr/lib/spark/conf/spark-defaults.conf

export SPARKLOCALIP=${SPARKLOCALIP:-${CURRENTIP:-"127.0.0.1"}}
export SPARKPUBLICDNS=${SPARKPUBLICDNS:-${CURRENTIP:-"127.0.0.1"}}
export SPARK_HOME=${SPARK_HOME:-"/usr/lib/spark"}
export PATH=$PATH:$SPARK_HOME/bin

cd $SPARK_HOME

. "./sbin/spark-config.sh"
. "./bin/load-spark-env.sh"

mkdir -p $SPARK_WORKER_LOG

ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker-$CURRENTIP.out

#/usr/lib/spark/sbin/../bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out
###!/bin/bash

exec "$@"
