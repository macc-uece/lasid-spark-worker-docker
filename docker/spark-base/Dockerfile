# Dockerfile for LASID Docker Spark Worker Docker Base Image
FROM ubuntu:bionic

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker-Base
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.7
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.12.12
ENV JAVA_VERSION=8
ENV SCALA_HOME=/usr/share/scala
ENV SPARK_HOME=/usr/lib/spark
ENV SPARK_GRAPH_PKG="0.8.1-spark3.0-s_2.12/graphframes-0.8.1-spark3.0-s_2.12.jar"
ENV SPARK_DELTA_PKG="delta-core_2.12/0.7.0/delta-core_2.12-0.7.0.jar"

#scala old version 2.11.12
# Fix the value of PYTHONHASHSEED
ENV PYTHONHASHSEED 1
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y wget software-properties-common 

# Install Java 
RUN apt-get -y install libnss3 openjdk-${JAVA_VERSION}-jre-headless gnupg2 --fix-missing 
#&& \
#    update-alternatives --install "/usr/bin/java" "java" "$(which java)" 1 && \
#    update-java-alternatives -s java-1.8.0-openjdk-amd64
ENV JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-openjdk-amd64/

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
RUN wget --no-verbose https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/lib/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#Graphframes install
RUN cd /usr/lib/spark/jars && \
    wget -nv http://dl.bintray.com/spark-packages/maven/graphframes/graphframes/${SPARK_GRAPH_PKG} && \
    wget -nv https://repo1.maven.org/maven2/io/delta/${SPARK_DELTA_PKG} && \
    chown -R root:root $SPARK_HOME && \
    pip install graphframes

# Clean instalation files 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
