# Build Spark Docker Worker
FROM lasid/spark-base

ARG SP_VERSION

ENV SPARK_HOME /usr/lib/spark
#ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
#ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /var/log/spark
ENV PATH $PATH:${SPARK_HOME}/bin
ENV PYSPARK_PYTHON python3
ENV SPARK_MASTER "mesos://zk://10.129.64.20:2181,10.129.64.10:2181,10.129.64.30:2181/mesos"

COPY . .

RUN if [ "$SP_VERSION" = "3" ] ; 
   then \
        cp ./spark-defaults_3.conf /usr/lib/spark/conf/spark-defaults.conf  ;
        cp ./spark-env_3.sh /usr/lib/spark/conf/spark-env.sh ;
    else \
        cp ./spark-defaults_2.conf /usr/lib/spark/conf/spark-defaults.conf ;
        cp ./spark-env_2.sh /usr/lib/spark/conf/spark-env.sh ;
    fi


#RUN if [ "$SP_VERSION" = "3" ] ; then cp ./spark-defaults_3.conf /usr/lib/spark/conf/spark-defaults.conf ; else \
#     cp ./spark-defaults_2.conf /usr/lib/spark/conf/spark-defaults.conf ; fi

#RUN if [ "$SP_VERSION" = "3" ] ; then cp ./spark-env_3.sh /usr/lib/spark/conf/spark-env.sh ; else \
#     cp ./spark-env_2.sh /usr/lib/spark/conf/spark-env.sh ; fi


COPY log4j.properties /usr/lib/spark/conf/
RUN chmod +x /usr/lib/spark/conf/spark-env.sh

EXPOSE 8080 8081

WORKDIR $SPARK_HOME

ENTRYPOINT /usr/lib/spark/bin/spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER
