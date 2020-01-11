# Dockerfile for LASID Spark Mesos Worker Docker
# Version 0.1
FROM ubuntu:bionic

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker

ENV DEBIAN_FRONTEND=noninteractive
ENV DAEMON_RUN=true
ENV SCALA_HOME=/usr/share/scala

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install gnupg2 software-properties-common wget
RUN apt-get -yq install apt-utils

# Install Java 
RUN apt-get -y install openjdk-8-jdk --fix-missing
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/

# Install Mesos
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
RUN echo "deb http://repos.mesosphere.com/ubuntu xenial main" | tee /etc/apt/sources.list.d/mesosphere.list	
RUN add-apt-repository -y ppa:xapienz/curl34
RUN apt-get -y update
RUN apt-get install -y libcurl4 # libevent-dev libcurl4-openssl-dev
RUN apt-get install -y mesos

# Install Python
RUN apt-get install -y python3-minimal python3-pip libnss3 
# python3-dev python3-setuptools --fix-missing

WORKDIR /

# Install Scala
RUN wget --no-verbose https://downloads.lightbend.com/scala/2.12.10/scala-2.12.10.deb &&  \
    dpkg -i scala-2.12.10.deb
RUN rm -f scala-2.12.10.deb

# Install Spark
RUN wget --no-verbose http://ftp.unicamp.br/pub/apache/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz && \
    tar -xzf /spark-2.4.4-bin-hadoop2.7.tgz && \
    mv /spark-2.4.4-bin-hadoop2.7 /usr/lib/spark
RUN rm -f spark-2.4.4-bin-hadoop2.7.tgz

#    echo "export PATH=$PATH:/usr/lib/spark/bin" >> /etc/profile.d/spark.sh && \
#    echo "export SPARK_HOME=/usr/lib/spark" >> /etc/profile.d/spark.sh

# Install Pyspark
#RUN pip3 install pyspark

#    echo "export PYSPARK_PYTHON=python3" >> /etc/profile.d/spark.sh

# Cleaning apt
RUN apt-get autoremove -y
RUN apt-get clean

# Set environment
COPY spark-conf/* /usr/lib/spark/conf/
COPY scripts /scripts

ENV MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so
ENV PYSPARK_PYTHON=python3
ENV PATH=$PATH:/usr/lib/spark/bin/
ENV SPARK_HOME=/usr/lib/spark

ENTRYPOINT ["/scripts/run.sh"]
