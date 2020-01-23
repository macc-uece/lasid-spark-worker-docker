#!/bin/bash

SPARK_MASTER=${SPARK_MASTER:-localhost}
MESOS_EXECUTOR_CORE=${MESOS_EXECUTOR_CORE:-0.1}
SPARK_IMAGE=${SPARK_IMAGE:-lasid/spark:lastest}
CURRENT_IP=$(hostname -i)

sed -i 's;SPARK_MASTER;'$SPARK_MASTER';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;MESOS_EXECUTOR_CORE;'$MESOS_EXECUTOR_CORE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;SPARK_IMAGE;'$SPARK_IMAGE';g' /usr/lib/spark/conf/spark-defaults.conf
sed -i 's;CURRENT_IP;'$CURRENT_IP';g' /usr/lib/spark/conf/spark-defaults.conf

export SPARK_LOCAL_IP=${SPARK_LOCAL_IP:-${CURRENT_IP:-"127.0.0.1"}}
export SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS:-${SPARK_PUBLIC_DNS:-"127.0.0.1"}}

export PYSPARK_PYTHON=python3
export PATH=$PATH:/usr/lib/spark/bin/
export SPARK_HOME=/usr/lib/spark

if [ $ADDITIONAL_VOLUMES ];
then
        echo "spark.mesos.executor.docker.volumes: $ADDITIONAL_VOLUMES" >> /usr/lib/spark/conf/spark-defaults.conf
fi

exec "$@"
