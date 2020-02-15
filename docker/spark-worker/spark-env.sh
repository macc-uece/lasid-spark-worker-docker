#!/usr/bin/env bash

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PYSPARK_PYTHON=/usr/bin/python
export PYSPARK_DRIVER_PYTHON=/usr/bin/python
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
export LIBPROCESS_IP=10.129.64.20
export SPARK_MASTER_IP=10.129.64.20
export SPARK_MASTER_HOST=10.129.64.20
export SPARK_MASTER_WEBUI_PORT=8000
export PATH=$PATH:/usr/lib/spark/bin
