#!/usr/bin/env bash
export MESOS_NATIVE_JAVA_LIBRARY=${MESOS_NATIVE_JAVA_LIBRARY:-/usr/lib/libmesos.so}
export SPARK_LOCAL_IP=${SPARK_LOCAL_IP:-"127.0.0.1"}
export SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS:-"127.0.0.1"}
export PYSPARK_PYTHON=python3
export PYTHONPATH=$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$SPARK_HOME/python/:$PYTHONPATH
export PATH=$PATH:/usr/lib/spark/bin/
export SPARK_HOME=/usr/lib/spark
