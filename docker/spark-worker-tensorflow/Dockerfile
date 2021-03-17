# Build Spark Docker Worker
FROM lasid/spark-worker

MAINTAINER Marcial Fernandez "marcial@larces.uece.br"
LABEL image=LASID-Spark-Worker-Tensorflow
LABEL author="Marcial Fernandez" email="marcial@larces.uece.br"

ENV SPARK_HOME /usr/lib/spark
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

# Install libraries
COPY ./requirements.txt .

RUN pip3 --no-cache-dir install --upgrade setuptools && \
    pip3 --no-cache-dir install --ignore-installed -r requirements.txt

# Clean instalation files 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080 8081

WORKDIR $SPARK_HOME

ENTRYPOINT /usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER
