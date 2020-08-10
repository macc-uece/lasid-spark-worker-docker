#!/usr/bin/env bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export SPARK_HOME=/usr/lib/spark
export PYSPARK_PYTHON=/usr/bin/python
export PYSPARK_DRIVER_PYTHON=/usr/bin/python
export PYTHONPATH=$PYTHONPATH:$SPARK_HOME/python
#export LIBPROCESS_IP=10.129.64.20
#export SPARK_MASTER_IP=10.129.64.20
#export SPARK_MASTER_HOST=10.129.64.20
export PATH=$PATH:$SPARK_HOME/bin
