# Build Spark Docker Worker
FROM lasid/spark-base

ENV SPARK_HOME /usr/lib/spark
ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /var/log/spark
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_PYTHON python3
ENV SPARK_MASTER "mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"

# Adds Mesosphere official repository, and install Mesos
# It is needed for libmesos.so
RUN apt-get -y update && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF && \
    echo "deb http://repos.mesosphere.com/ubuntu xenial main" | tee /etc/apt/sources.list.d/mesosphere.list && \
    add-apt-repository -y ppa:xapienz/curl34  && \
    apt-get -y update && \
    apt-get -y install libcurl4 libcurl4-openssl-dev libssl1.0.0 mesos && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY start-worker.sh /
COPY spark-defaults.conf /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/
RUN chmod +x /usr/lib/spark/conf/spark-env.sh
RUN chmod +x /start-worker.sh

ENV MESOS_NATIVE_JAVA_LIBRARY=/usr/lib/libmesos.so
ENV PYSPARK_PYTHON python3

EXPOSE 8081

#WORKDIR $SPARK_HOME

#CMD ["/bin/bash", "/start-worker.sh"]
ENTRYPOINT ["/start-worker.sh"]
