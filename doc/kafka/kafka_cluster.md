# 金石大数据日志分析平台

## 搭建 Kafka 日志采集集群

### 开启zookeeper

```
# 1.单个zookeeper节点
$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties
```

### 开启broker
```
# 1.开启单个broker
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties &
# 2.开启多个broker
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-1.properties &
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-2.properties

# 开启集群
# hk01
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-hk01.properties &
# hk02
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-hk02.properties &
# hk03
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-hk03.properties &
# hk04
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server-hk04.properties &

# 关闭集群
$KAFKA_HOME/bin/kafka-server-stop.sh $KAFKA_HOME/config/server-hk01.properties
$KAFKA_HOME/bin/kafka-server-stop.sh $KAFKA_HOME/config/server-hk02.properties
$KAFKA_HOME/bin/kafka-server-stop.sh $KAFKA_HOME/config/server-hk03.properties
$KAFKA_HOME/bin/kafka-server-stop.sh $KAFKA_HOME/config/server-hk04.properties
```

### 创建topic
```
# 1.单个replica
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 2 --partitions 3 --topic log-topic
# 2.多个replica
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic replicated-kafkatopic
# 集群模式下
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper hk01:2181,hk02:2181,hk03:2181,hk04:2181/kafka --replication-factor 4 --partitions 2 --topic log-topic

# 列出当前topic
$KAFKA_HOME/bin/kafka-topics.sh --list --zookeeper localhost:2181 kafkatopic
# 集群模式下
$KAFKA_HOME/bin/kafka-topics.sh --list --zookeeper hk01:2181,hk02:2181,hk03:2181,hk04:2181/kafka log-topic
```

### 获得topic详情
```
$KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper localhost:2181 --topic log-topic
# 集群模式下
$KAFKA_HOME/bin/kafka-topics.sh --describe --zookeeper hk01:2181,hk02:2181,hk03:2181,hk04:2181/kafka --topic log-topic
```

### 创建多个replica
```
$KAFKA_HOME/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 3 --partitions 1 --topic replicatedkafkatest
```

### 生产消息
```
＃ 1.单个broker
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic kafkatopic
# 2.多个broker
$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list localhost:9092, localhost:9093 --topic replicated-kafkatopic
```

### 消费数据
```
$KAFKA_HOME/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic log-topic --from-beginning
$KAFKA_HOME/bin/kafka-console-consumer.sh --zookeeper localhost:2181 --topic replicated-kafkatopic --from-beginning
# 集群模式下
$KAFKA_HOME/bin/kafka-console-consumer.sh --zookeeper hk01:2181,hk02:2181,hk03:2181,hk04:2181/kafka --topic log-topic --from-beginning
```
### 与Flume整合
```
1.复制libs下的jar包到flumelibs下面
cp $KAFKA_HOME/libs/kafka-clients-0.9.0.1.jar $FLUME_HOME/lib/
cp kafka_2.10-0.9.0.1.jar ~/kafka/
cp metrics-core-2.2.0.jar ~/kafka/
cp scala-library-2.10.5.jar ~/kafka/
cp ~/kafka/* /opt/app/flume/apache-flume-1.6.0-bin/lib/
2.复制自定义KafkaSink.jar
scp out/artifacts/KafkaSink_jar/KafkaSink.jar root@203.12.202.66:/opt/app/flume/apache-flume-1.6.0-bin/lib/
cp ~/kafka/KafkaSink.jar $FLUME_HOME/lib/
```

### 复制文件操作
```
scp -r root@203.12.202.66:/opt/app/kafka/kafka_2.10-0.9.0.1/config/server.properties conf/kafka/server.properties                      
scp -r conf/kafka/* root@203.12.202.66:/opt/app/kafka/kafka_2.10-0.9.0.1/config/
scp -r $KAFKA_HOME/config/* hk02:$KAFKA_HOME/config/
scp -r $KAFKA_HOME/config/* hk03:$KAFKA_HOME/config/
scp -r $KAFKA_HOME/config/* hk04:$KAFKA_HOME/config/
```

### 参考文档
```
[Kafka集群操作指南](http://www.lujinhong.com/kafka%E9%9B%86%E7%BE%A4%E6%93%8D%E4%BD%9C%E6%8C%87%E5%8D%97.html)
```