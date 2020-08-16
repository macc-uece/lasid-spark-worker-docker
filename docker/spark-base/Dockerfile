# Dockerfile for LASID Docker Spark Worker Docker Base Image
# Version 0.4
FROM ubuntu:bionic

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker-Base
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"
LABEL version="0.4"

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.6
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.12.11    
ENV SCALA_HOME=/usr/share/scala
ENV SPARK_HOME=/usr/lib/spark

#scala old version 2.11.12
# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y wget software-properties-common 

# Install Java 
RUN apt-get -y install libnss3 openjdk-8-jre-headless gnupg2 --fix-missing 
#&& \
#    update-alternatives --install "/usr/bin/java" "java" "$(which java)" 1 && \
#    update-java-alternatives -s java-1.8.0-openjdk-amd64
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

#Scala instalation
RUN cd "/tmp" && \
    wget --no-verbose https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.deb &&  \
    dpkg -i scala-${SCALA_VERSION}.deb && \
    rm -f scala-${SCALA_VERSION}.deb

#Python 3 instalation
RUN apt-get install -y python3 python3-pip python3-setuptools && \
    update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1 && \
    pip3 install --upgrade pip
 
#Spark install
RUN wget --no-verbose http://ftp.unicamp.br/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/lib/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#Graphframes install
RUN cd /usr/lib/spark/jars && \
    wget --no-verbose http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/0.7.0-spark2.4-s_2.11/graphframes-0.7.0-spark2.4-s_2.11.jar &&\
    chown -R root:root $SPARK_HOME && \
    pip install graphframes

# Clean instalation files 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
