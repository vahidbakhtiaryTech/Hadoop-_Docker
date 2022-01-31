FROM vahidbakhtiaryinfo/hadoop:2.0


# install packages
RUN \
  apt-get update && apt-get install -y \
  curl










  



# Stage 2 - Build Hive base


ENV HIVE_HOME=/usr/local/hive
ENV PATH=$HIVE_HOME/bin:$PATH
ENV HIVE_CONF_DIR=$HIVE_HOME/conf

ARG HIVE_VERSION=3.1.2
ARG HIVE_DOWNLOAD_DIR=/tmp/hive
ARG POSTGRESQL_JDBC_VERSION=42.2.14

 

 

RUN wget https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz  && \
    tar -xzvf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    mv apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME} && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz \
  && mkdir -pv $HIVE_DOWNLOAD_DIR \
  && chown -R root:root "${HIVE_HOME}" \
  && mkdir -p "${HIVE_HOME}/hcatalog/var/log" \
  && mkdir -p "${HIVE_HOME}/var/log" \
  && mkdir -p "${HIVE_CONF_DIR}" \
  && chmod 777 "${HIVE_HOME}/hcatalog/var/log" \
  && chmod 777 "${HIVE_HOME}/var/log" \
  && rm -rfv $HIVE_HOME/lib/guava-*.jar \
  && cp $HADOOP_HOME/share/hadoop/common/lib/guava-*.jar $HIVE_HOME/lib/ \
  && rm -rfv $HIVE_HOME/lib/postgresql-*.jre*.jar 


RUN curl -fSL https://jdbc.postgresql.org/download/postgresql-$POSTGRESQL_JDBC_VERSION.jar -o $HIVE_HOME/lib/postgresql-jdbc.jar





# --------------------------------------------------------
# SQOOP
# --------------------------------------------------------
ENV SQOOP_VERSION=1.4.7
ENV SQOOP_HOME=/usr/local/sqoop
ENV PATH=$PATH:${SQOOP_HOME}/bin

RUN curl -fSL https://downloads.apache.org/sqoop/${SQOOP_VERSION}/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz -o /tmp/sqoop.tar.gz \
    && tar -xvf /tmp/sqoop.tar.gz -C /usr/local/ \
    && rm /tmp/sqoop.tar.gz

ADD config/sqoop-env.sh ${SQOOP_HOME}/conf
ADD config/sqljdbc42.jar ${SQOOP_HOME}/lib

RUN cp $HIVE_HOME/lib/postgresql-jdbc.jar ${SQOOP_HOME}/lib/postgresql-jdbc.jar







# Custom configuration goes here
ADD config/hive-site.xml $HIVE_CONF_DIR
ADD config/core-site.xml $HADOOP_HOME
ADD sh/*sh $HIVE_HOME/bin/
ADD conf/metastore-site.xml $HIVE_CONF_DIR
ADD conf/metastore-log4j2.properties $HIVE_CONF_DIR
ADD conf/beeline-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-exec-log4j2.properties $HIVE_CONF_DIR
ADD conf/hive-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-daemon-log4j2.properties $HIVE_CONF_DIR
ADD conf/llap-cli-log4j2.properties $HIVE_CONF_DIR
RUN mkdir $HIVE_HOME/logs



EXPOSE 9083 10000 10002