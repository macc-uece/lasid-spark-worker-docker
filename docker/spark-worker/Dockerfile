# Build Spark Docker Worker
FROM lasid/spark-base

ENV SPARK_HOME /usr/lib/spark
ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /var/log/spark
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_PYTHON python3
#ENV SPARK_MASTER "spark://spark-master:7077"

COPY start-worker.sh /
COPY spark-defaults.conf /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/

RUN chmod +x /start-worker.sh

WORKDIR $SPARK_HOME
EXPOSE 7000-8000 4040 6066 7077 8080 8081 7070

WORKDIR $SPARK_HOME
CMD ["/bin/bash", "/start-worker.sh"]
