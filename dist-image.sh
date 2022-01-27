#!/bin/bash
#
# Download docker image in all servers

if [ $1 == '3' ] ; then
	SPARK_VER="3.2.0"
elif [ $1 == '2' ] ; then
	SPARK_VER="2.4.8"
else
	echo "Script to distribute LASID Spark Docker image over servers."
	echo "Usage: ./dist-images.sh <Spark> " 
	echo "  <Spark> Spark major number version, i.e., 2 or 3" 
	exit 1
fi

UBUNTU_VER="bionic"

ssh -tt stack@lasid10 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid30 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid40 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid50 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid60 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid70 "docker pull lasid/spark-worker:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid10 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid30 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid40 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid50 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid60 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
ssh -tt stack@lasid70 "docker pull lasid/spark-worker-tensorflow:${SPARK_VER}_${UBUNTU_VER}"
