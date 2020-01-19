# Build Spark Docker Worker
FROM lasid/spark-base

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

COPY start-worker.sh /
COPY spark-defaults.conf /usr/lib/spark/conf/
COPY spark-env.sh /usr/lib/spark/conf/

EXPOSE 8081

CMD ["/bin/bash", "/start-worker.sh"]
