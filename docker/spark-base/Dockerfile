# Dockerfile for LASID Docker Spark Worker Docker Base Image
# Version 0.4
FROM ubuntu:bionic

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"
LABEL version="0.4"

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.11.12
ENV SCALA_HOME=/usr/share/scala
ENV SPARK_HOME=/usr/lib/spark

# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y wget software-properties-common 

# Install Java 
RUN apt-get -y install openjdk-8-jre-headless gnupg2 --fix-missing
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

#Scala instalation
RUN cd "/tmp" && \
    wget --no-verbose https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.deb &&  \
    dpkg -i scala-${SCALA_VERSION}.deb && \
    rm -f scala-${SCALA_VERSION}.deb

#Python instalation
RUN apt-get install -y python3 python3-pip && \
    update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
 
#Spark install
RUN wget --no-verbose http://ftp.unicamp.br/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/lib/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#Graphframes install
RUN cd /usr/lib/spark/jars && \
    wget --no-verbose http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.7.0-spark2.4-s_2.11/graphframes-0.7.0-spark2.4-s_2.11.jar &&\
    pip3 install --upgrade pip && \
    pip install graphframes
