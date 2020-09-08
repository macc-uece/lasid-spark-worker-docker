# Build Spark Docker Worker
FROM lasid/spark-base

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"
LABEL version="0.4"

ENV SPARK_HOME /usr/lib/spark
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
#ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /data/software/mgmt/log/spark-log/
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_PYTHON python3
ENV SPARK_MASTER "mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"
#ENV CORES=2
#ENV MEMORY=4G

COPY spark-defaults.conf /usr/lib/spark/conf/
COPY log4j.properties /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/
RUN chmod +x /usr/lib/spark/conf/spark-env.sh

# Install libraries
COPY ./requirements.txt .
RUN pip install --use-feature=2020-resolver -r requirements.txt 

#USER root
#USER stack

EXPOSE 8080 8081 8082 8083 8084

WORKDIR $SPARK_HOME

ENTRYPOINT /usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER
