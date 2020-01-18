# Dockerfile for LASID Docker Spark Worker Docker Base Image
# Version 0.1
FROM openjdk:8     #-alpine

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"
LABEL version="0.2"

ENV DAEMON_RUN=true
ENV SPARK_VERSION=2.4.4
ENV HADOOP_VERSION=2.7
ENV SCALA_VERSION=2.12.10
ENV SCALA_HOME=/usr/share/scala
ENV SPARK_HOME=/usr/lib/spark

RUN apt-get update && apt -y upgrade && apt-get install -y curl vim wget software-properties-common ssh net-tools ca-certificates jq

#     apt update && apt -y upgrade \
#     apt install -y wget ca-certificates && \
#     apt install -y curl bash jq && \
RUN cd "/tmp" && \
    wget --no-verbose https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.deb &&  \
    dpkg -i scala-${SCALA_VERSION}.deb
    rm -f scala-2.12.10.deb
    rm -rf "/tmp/"*

# RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
#     apk add --no-cache bash curl jq && \
#     cd "/tmp" && \
#     wget --no-verbose "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
#     tar xzf "scala-${SCALA_VERSION}.tgz" && \
#     mkdir "${SCALA_HOME}" && \
#     rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
#     mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
#     ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
#     apk del .build-dependencies && \
#     rm -rf "/tmp/"*


# Add Dependencies for PySpark
RUN apt-get install -y python3 #python3-pip python3-numpy python3-matplotlib python3-scipy python3-pandas python3-simpy
RUN update-alternatives --install "/usr/bin/python" "python" "$(which python3)" 1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
 
#Scala instalation
#RUN export PATH="/usr/local/sbt/bin:$PATH" &&  apt update && apt install ca-certificates wget tar && mkdir -p "/usr/local/sbt" && wget -qO - --no-check-certificate "https://github.com/sbt/sbt/releases/download/v1.2.8/sbt-1.2.8.tgz" | tar xz -C /usr/local/sbt --strip-components=1 && sbt sbtVersion

RUN wget --no-verbose http://ftp.unicamp.br/pub/apache/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/lib/spark \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1