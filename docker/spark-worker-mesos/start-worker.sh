#!/bin/bash

####!/usr/bin/env bash

#. "./sbin/spark-config.sh"
#. "./bin/load-spark-env.sh"

##export SPARKMASTER=${SPARK_MASTER:-"mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"}
##export MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
#export SPARKIMAGE=${SPARKIMAGE:-"lasid/spark-worker:latest"}
##export CURRENTIP=$(hostname -i)
##export SPARK_LOCAL_IP=$CURRENTIP
##export SPARK_WORKER_LOG=${SPARK_WORKER_LOG:-"/var/log/spark"}
##export SPARK_WORKER_WEBUI_PORT=${SPARK_WORKER_WEBUI_PORT:-"8081"}
#export SPARKLOCALIP=${SPARKLOCALIP:-${CURRENTIP:-"127.0.0.1"}}
#export SPARKPUBLICDNS=${SPARKPUBLICDNS:-${CURRENTIP:-"127.0.0.1"}}
export SPARK_HOME=${SPARK_HOME:-"/usr/lib/spark"}
export PATH=$PATH:$SPARK_HOME/bin

#cd $SPARK_HOME

#mkdir -p $SPARK_WORKER_LOG

#ln -sf /dev/stdout $SPARK_WORKER_LOG/spark-worker-$CURRENTIP.out

#/usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker --webui-port $SPARK_WORKER_WEBUI_PORT $SPARK_MASTER >> $SPARK_WORKER_LOG/spark-worker.out

#exec "$@"


SPARK_MASTER=${SPARK_MASTER:-local}
MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
SPARK_IMAGE=${SPARK_IMAGE:-lasid/spark-worker-mesos:latest}
CURRENT_IP=$(hostname -i)

echo "current ip: $CURRENT_IP"
#export LIBPROCESS_IP=$CURRENT_IP

sed -i 's;SPARK_MASTER;'$SPARK_MASTER';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;MESOS_EXECUTOR_CORE;'$MESOS_EXECUTOR_CORE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;SPARK_IMAGE;'$SPARK_IMAGE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;CURRENT_IP;'$CURRENT_IP';g' /usr/lib/spark/conf/spark-defaults.conf

if [ $ADDITIONAL_VOLUMES ];
then
        echo "spark.mesos.executor.docker.volumes: $ADDITIONAL_VOLUMES" >> /opt/spark/conf/spark-defaults.conf
fi

exec "$@"
