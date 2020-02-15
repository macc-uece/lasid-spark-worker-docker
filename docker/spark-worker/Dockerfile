# Build Spark Docker Worker
FROM lasid/spark-base

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /var/spark/logs
#ENV SPARK_MASTER "spark://spark-master:7077"

COPY start-worker.sh /
COPY spark-defaults.conf /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/

RUN chmod +x /start-worker.sh
ENV PATH $PATH:/usr/lib/spark/bin

WORKDIR $SPARK_HOME
EXPOSE 4040 6066 7077 8080 8081 7070

CMD ["/bin/bash", "/start-worker.sh"]
