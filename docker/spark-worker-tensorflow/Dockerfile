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

# Install some Tensorflow dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl libfreetype6-dev libpng-dev libzmq3-dev pkg-config \
    rsync unzip pkg-config libpcre3-dev zlib1g-dev liblzma-dev 

# Clean instalation files 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install libraries
COPY ./requirements.txt .

RUN pip3 --no-cache-dir install --upgrade setuptools && \
    pip3 --no-cache-dir install --ignore-installed --use-feature=2020-resolver -r requirements.txt

COPY spark-defaults.conf /usr/lib/spark/conf/
COPY log4j.properties /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/
RUN chmod +x /usr/lib/spark/conf/spark-env.sh

EXPOSE 8080 8081

WORKDIR $SPARK_HOME

ENTRYPOINT /usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER
