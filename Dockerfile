# Dockerfile for LASID Spark Mesos Worker Docker
# Version 0.1

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
ENV REFRESHED_AT 2019-01-10

FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV DAEMON_RUN=true
ENV SPARK_VERSION="2.4.4"
ENV HADOOP_VERSION="2.7"
ENV SCALA_VERSION="2.12.10"
ENV SCALA_HOME=/usr/share/scala

RUN apt update
RUN apt upgrade -y
RUN apt autoremove -y

# Install Java 
RUN apt-get -y purge openjdk*
RUN apt-get -y purge oracle-java8-installer
RUN sudo apt-get -y purge oracle-java11-installer
RUN sudo apt -y update; sudo apt -y install openjdk-8-jdk

ENV JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:jre/bin/java::")

# Install Mesos
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
RUN echo "deb http://repos.mesosphere.com/ubuntu xenial main" | tee /etc/apt/sources.list.d/mesosphere.list	
RUN add-apt-repository -y ppa:xapienz/curl34
RUN apt-get -y update
RUN apt install libcurl4 libevent-dev libcurl4-openssl-dev -y
RUN apt-get -y install mesos

# Install Python
RUN apt-get install -y python3-minimal python3-pip build-essential python3-dev python3-setuptools libnss3 curl

# Install Scala
RUN curl https://downloads.lightbend.com/scala/"$SCALA_VERSION"/scala-"$SCALA_VERSION".deb | dpkg -i scala-"$SCALA_VERSION".deb

# Install Spark
    	cd /usr/lib
RUN 'curl http://ftp.unicamp.br/pub/apache/spark/spark-'"$SPARK_VERSION"'/spark-'"$SPARK_VERSION"'-bin-hadoop'"$HADOOP_VERSION"'.tgz' \
    | tar -xzC /usr/lib && mv /usr/lib/spark* /usr/lib/spark
RUN rm -f 'spark-'"$SPARK_VERSION"'-bin-hadoop'"$HADOOP_VERSION"'.tgz'

# Install Pyspark
RUN pip3 install pyspark


echo "export PYSPARK_PYTHON=python3" >> .bashrc

	echo "export PATH=\$PATH:/usr/lib/spark/bin/" >> .bashrc
	echo "export SPARK_HOME=/usr/lib/spark" >> .bashrc


RUN apt-get clean

COPY spark-conf/* /opt/spark/conf/
COPY scripts /scripts

ENV SPARK_HOME /usr/lib/spark

ENTRYPOINT ["/scripts/run.sh"]
