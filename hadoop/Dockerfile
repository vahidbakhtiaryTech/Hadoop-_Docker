FROM ubuntu:16.04



# set environment vars
ENV HADOOP_HOME /usr/local/hadoop
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $PATH:$JAVA_HOME/bin
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin 

# install packages
RUN \
  apt-get update && apt-get install -y \
  ssh \
  rsync \
  vim \
  openjdk-8-jdk

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys


RUN mkdir -p $HADOOP_HOME/namenode && \ 
    mkdir -p $HADOOP_HOME/datanode && \
    mkdir $HADOOP_HOME/logs



  # download and extract hadoop, set JAVA_HOME in hadoop-env.sh, update path
 ENV HADOOP_VERSION 3.3.1
 ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
 RUN curl -fSL https://dist.apache.org/repos/dist/release/hadoop/common/KEYS -o /tmp/hadoop_keys && \
    gpg --import /tmp/hadoop_keys

RUN set -x && \
    curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz && \
    curl -fSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc && \
    gpg --verify /tmp/hadoop.tar.gz.asc && \
    tar -xvf /tmp/hadoop.tar.gz -C /usr/local/ && \
    rm /tmp/hadoop.tar.gz* && \
    ln -s /usr/local/hadoop-$HADOOP_VERSION /usr/local/hadoop && \
    ln -s /usr/local/hadoop-$HADOOP_VERSION /hadoop 

COPY config/* /tmp/
RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh /usr/local/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

  

# Hadoop env
ENV HADOOP_HOME=/usr/local/hadoop
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
ENV HADOOP_LOG_DIR=${HADOOP_HOME}/logs
ENV PATH $HADOOP_HOME/bin/:$PATH




# expose various ports
EXPOSE 8088 50070 50075 50030 50060