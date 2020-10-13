#!/bin/bash

if [ $1 == '3' ] ; then
	SPARK_VER="3.0.1"
	JAVA_VER="11"
	HADOOP_VER="3.2"
	SCALA_VERSION="2.12.12"
        SPARK_GRAPH_PKG="0.8.1-spark3.0-s_2.12/graphframes-0.8.1-spark3.0-s_2.12.jar" 
        SPARK_DELTA_PKG="delta-core_2.12/0.7.0/delta-core_2.12-0.7.0.jar" 
elif [ $1 == '2' ] ; then
	SPARK_VER="2.4.7"
	JAVA_VER="8"
	HADOOP_VER="2.7"
	SCALA_VERSION="2.11.12"
        SPARK_GRAPH_PKG="0.8.1-spark2.4-s_2.11/graphframes-0.8.1-spark2.4-s_2.11.jar" 
        SPARK_DELTA_PKG="delta-core_2.11/0.6.1/delta-core_2.11-0.6.1.jar"
else
	echo "Script to build LASID Spark Docker image."
	echo "Usage: ./build-images.sh <Spark> " 
	echo "    <Spark> Spark major number version, i.e., 2 or 3" 
	exit 1
fi

UBUNTU_VER="bionic"

set -e

## Build Docker image
docker build --build-arg SP_VERSION=${SPARK_VER} --build-arg JV_VERSION=${JAVA_VER} --build-arg SC_VERSION=${SCALA_VERSION} \
             --build-arg HD_VERSION=${HADOOP_VER} --build-arg SP_G_PKG=${SPARK_GRAPH_PKG} --build-arg SP_D_PKG=${SPARK_DELTA_PKG} \
             -t lasid/spark-base:${SPARK_VER}_${UBUNTU_VER}  -t lasid/spark-base:latest ./docker/spark-base
docker build --build-arg SP_VERSION=${SPARK_VER} -t lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER} \
             -t lasid/spark-worker:latest ./docker/spark-worker
docker build -t lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER} -t lasid/spark-worker-tensorflow:latest \
             ./docker/spark-worker-tensorflow

## Push image to DockerHub
docker login
#docker push lasid/spark-worker:latest
docker push lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}
#docker push lasid/spark-worker-tensorflow:latest
docker push lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}
