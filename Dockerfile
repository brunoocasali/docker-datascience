FROM jupyter/pyspark-notebook

LABEL maintainer="Bruno Casali <hi@brunoocasali.xyz>"

RUN conda update -n base conda
RUN conda install pyspark

USER root

# Install Hadoop
RUN mkdir /usr/local/hadoop
RUN wget --no-verbose -O /usr/local/hadoop/hadoop-3.1.0.tar.gz http://apache.claz.org/hadoop/common/hadoop-3.1.0/hadoop-3.1.0.tar.gz | tar -xz -C /usr/local/hadoop --strip-components 1
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_INSTALL $HADOOP_HOME
ENV PATH $PATH:$HADOOP_INSTALL/sbin
ENV HADOOP_MAPRED_HOME $HADOOP_INSTALL
ENV HADOOP_COMMON_HOME $HADOOP_INSTALL
ENV HADOOP_HDFS_HOME $HADOOP_INSTALL
ENV YARN_HOME $HADOOP_INSTALL
ENV PATH $HADOOP_HOME/bin:$PATH

# Update Software repository
RUN apt-get update

# Install Hive
RUN mkdir /usr/local/hive
RUN wget --no-verbose -O /usr/local/hive/apache-hive-2.1.0-bin.tar.gz wget http://archive.apache.org/dist/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz | tar -xz -C /usr/local/hive --strip-components 1
ENV HIVE_HOME /usr/local/hive
ENV PATH $HIVE_HOME/bin:$PATH

# Derby for Hive metastore backend
RUN cd $HIVE_HOME && $HIVE_HOME/bin/schematool -initSchema -dbType derby