#!/usr/bin/env bash
# #!/bin/bash
### 项目默认目录
mkdir -p /opt/app/data
mkdir -p /opt/app/flume
mkdir -p /opt/app/kafka
mkdir -p /opt/app/kafka/kafka-logs-hk01
mkdir -p /opt/app/kafka/kafka-logs-hk02
mkdir -p /opt/app/kafka/kafka-logs-hk03
mkdir -p /opt/app/spark
mkdir -p /opt/app/zeppelin
mkdir -p /opt/app/zookeeper
mkdir -p /opt/app/zookeeper/data
mkdir -p /opt/app/java
mkdir -p /opt/app/scala
mkdir -p /opt/app/elasticsearch
mkdir -p /opt/app/logstash
mkdir -p /opt/app/kibana
### 下载所需软件
git clone git@git.coding.net:noprom/KingsGameLogPlatform.git
mv /opt/KingsGameLogPlatform /opt/app/
# 1.下载jdk
wget -P /opt/app/java https://coding.net/u/noprom/p/software-archives/git/archive/jdk-7u79-linux-x64.tar.gz
# 2.下载scala
wget -P /opt/app/scala http://www.scala-lang.org/files/archive/scala-2.10.4.tgz
# 3.下载maven
wget -P /opt/app/maven http://mirror.bit.edu.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
# 4.下载flume
wget -P /opt/app/flume http://mirrors.cnnic.cn/apache/flume/1.6.0/apache-flume-1.6.0-bin.tar.gz
# 5.下载kafka
wget -P /opt/app/kafka http://apache.fayea.com/kafka/0.9.0.1/kafka_2.10-0.9.0.1.tgz
# 6.下载spark
wget -P /opt/app/spark http://apache.opencas.org/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
# 7.下载zeppelin
wget -P /opt/app/zeppelin http://mirrors.cnnic.cn/apache/incubator/zeppelin/0.5.6-incubating/zeppelin-0.5.6-incubating-bin-all.tgz
# 8.下载zookeeper
wget -P /opt/app/zookeeper http://apache.opencas.org/zookeeper/stable/zookeeper-3.4.8.tar.gz
# 9.下载elasticsearch
wget -P /opt/app/elasticsearch https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.3.1/elasticsearch-2.3.1.tar.gz
# 10.下载logstash
wget -P /opt/app/logstash https://download.elastic.co/logstash/logstash/logstash-2.3.1.tar.gz
# 11.下载kibana
wget -P /opt/app/kibana https://download.elastic.co/kibana/kibana/kibana-4.5.0-linux-x64.tar.gz

### 安装软件
# 1.安装jdk
tar -zxvf /opt/app/java/jdk-7u79-linux-x64.tar.gz -C /opt/app/java
tar -zxvf /opt/app/java/software-archives-jdk-7u79-linux-x64/jdk-7u79-linux-x64.tar.gz -C /opt/app/java
mv /opt/app/java/software-archives-jdk-7u79-linux-x64/jdk-7u79-linux-x64.tar.gz /opt/app/java/jdk-7u79-linux-x64.tar.gz
rm -rf /opt/app/java/software-archives-jdk-7u79-linux-x64
# 2.安装scala
tar -zxvf /opt/app/scala/scala-2.10.4.tgz -C /opt/app/scala
# 3.安装maven
tar -zxvf /opt/app/maven/apache-maven-3.3.9-bin.tar.gz -C /opt/app/maven
# 4.安装flume
tar -zxvf /opt/app/flume/apache-flume-1.6.0-bin.tar.gz -C /opt/app/flume
# 5.安装kafka
tar -zxvf /opt/app/kafka/kafka_2.10-0.9.0.1.tgz -C /opt/app/kafka
# 6.安装spark
tar -zxvf /opt/app/spark/spark-1.6.1-bin-hadoop2.6.tgz -C /opt/app/spark
# 7.安装zeppelin
tar -zxvf /opt/app/zeppelin/zeppelin-0.5.6-incubating-bin-all.tgz -C /opt/app/zeppelin
# 8.安装zookeeper
tar -zxvf /opt/app/zookeeper/zookeeper-3.4.8.tar.gz -C /opt/app/zookeeper
# 9.安装elasticsearch
tar -zxvf /opt/app/elasticsearch/elasticsearch-2.3.1.tar.gz -C /opt/app/elasticsearch
# 10.安装logstash
tar -zxvf /opt/app/logstash/logstash-2.3.1.tar.gz -C /opt/app/logstash
# 11.安装kibana
tar -zxvf /opt/app/kibana/kibana-4.5.0-linux-x64.tar.gz -C /opt/app/kibana

### 配置环境变量
cat /opt/app/KingsGameLogPlatform/conf/profile >> /etc/profile
source /etc/profile

### 验证是否安装完成
java -version
scala -version
mvn -version
echo $JAVA_HOME
echo $SCALA_HOME
echo $M2_HOME
echo $FLUME_HOME
echo $KAFKA_HOME
echo $SPARK_HOME
echo $ELASTICSEARCH_HOME
echo $LOGSTASH_HOME
echo $KIBANA_HOME
echo $ZOOKEEPER_HOME
echo $ZEPPELIN_HOME

### 替换默认框架配置文件
# 1.flume
cp -r /opt/app/KingsGameLogPlatform/conf/flume/cluster/* $FLUME_HOME/conf/
cp -r /opt/app/KingsGameLogPlatform/lib/KafkaSink.jar $FLUME_HOME/lib/
cp $KAFKA_HOME/libs/kafka-clients-0.9.0.1.jar $FLUME_HOME/lib/
cp $KAFKA_HOME/libs/kafka_2.10-0.9.0.1.jar $FLUME_HOME/lib/
cp $KAFKA_HOME/libs/metrics-core-2.2.0.jar $FLUME_HOME/lib/
cp $KAFKA_HOME/libs/scala-library-2.10.5.jar $FLUME_HOME/lib/
# 2.kafka
cp -r /opt/app/KingsGameLogPlatform/conf/kafka/cluster/* $KAFKA_HOME/config/
# 3.spark
cp -r /opt/app/KingsGameLogPlatform/conf/spark/cluster/* $SPARK_HOME/conf/
# 4.zookeeper
cp -r /opt/app/KingsGameLogPlatform/conf/zookeeper/zoo.cfg $ZOOKEEPER_HOME/conf/