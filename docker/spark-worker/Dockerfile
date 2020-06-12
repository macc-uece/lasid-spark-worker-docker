# Build Spark Docker Worker
FROM lasid/spark-base

ENV SPARK_HOME /usr/lib/spark
#ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /var/log/spark
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_PYTHON python3
ENV SPARK_MASTER "mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"
ENV CORES=3
ENV MEMORY=20G

#COPY start-worker.sh /
COPY spark-defaults.conf /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/
RUN chmod +x /usr/lib/spark/conf/spark-env.sh
#RUN chmod +x /start-worker.sh

#USER root

#EXPOSE 7000-8000 4040 6066 7077  8081 7070
#EXPOSE 4040 6066 7077 7001 7002 7003 7004 7005 7006 8080 8081 8888
#EXPOSE 8081 4040 8086 8087 8088 8089
EXPOSE 8080 8081 8082 8083 8084

#WORKDIR $SPARK_HOME

#WORKDIR /

#CMD ["/bin/bash"]
#CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
#CMD ["/bin/bash", "/start-worker.sh"]
#-c $CORES -m $MEMORY 

ENTRYPOINT $SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER
