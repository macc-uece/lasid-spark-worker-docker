# Dockerfile for LASID Spark Mesos Worker Docker
# Version 0.1
FROM ubuntu:bionic

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"

ARG DEBIAN_FRONTEND=noninteractive
ENV DAEMON_RUN=true
ARG SCALA_HOME=/usr/share/scala

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get autoremove -y
RUN apt-get -y install gnupg2 software-properties-common
RUN apt-get -yq install apt-utils

# Install Java 
RUN apt-get -y install openjdk-8-jdk --fix-missing

ENV JAVA_HOME=/usr/lib/jvm/default-java

# Install Mesos
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
RUN echo "deb http://repos.mesosphere.com/ubuntu xenial main" | tee /etc/apt/sources.list.d/mesosphere.list	
RUN add-apt-repository -y ppa:xapienz/curl34
RUN apt-get -y update
RUN apt-get install libcurl4 libevent-dev libcurl4-openssl-dev -y
RUN apt-get -y install mesos

# Install Python
RUN apt-get install -y python3-minimal python3-pip build-essential python3-dev python3-setuptools libnss3 curl

# Install Scala
RUN curl https://downloads.lightbend.com/scala/2.12.10/scala-2.12.10.deb
RUN dpkg -i scala-2.12.10.deb

# Install Spark
RUN cd /usr/lib
RUN curl http://ftp.unicamp.br/pub/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz \
    && tar -xzC /usr/lib && mv /usr/lib/spark* /usr/lib/spark
RUN rm -f spark-2.4.4-bin-hadoop2.7.tgz

# Install Pyspark
RUN pip3 install pyspark

# Cleaning apt
RUN apt-get clean

COPY spark-conf/* /opt/spark/conf/
COPY scripts /scripts

ENV SPARK_HOME /usr/lib/spark

ENTRYPOINT ["/scripts/run.sh"]
