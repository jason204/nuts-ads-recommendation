# 金石大数据日志分析平台

## 搭建 Flume 日志采集集群

### 设置配置文件
```
# 1.配置环境配置文件
cp flume-env.sh.template flume-env.sh
vim flume-env.sh
# 加入以下内容

export JAVA_HOME=/usr/local/etc/java/jdk1.7.0_79

# 2.设置配置文件
scp conf/flume/flume-kafka.conf root@203.12.202.66:~/flume/
cp ~/flume/flume-kafka.conf /opt/app/flume/apache-flume-1.6.0-bin/lib/

# 3.复制到slave机器
# cd 到 复制文件shell处
chmod +x install_flume_cluster.sh
./install_flume_cluster.sh

```

### Flume 操作
```
# flume 后台启动使用nohup命令
nohup $FLUME_HOME/bin/flume-ng agent --conf $FLUME_HOME/conf --conf-file $FLUME_HOME/conf/flume-kafka.conf --name agentkafka

# 开启flume
$FLUME_HOME/bin/flume-ng agent --conf $FLUME_HOME/conf --conf-file $FLUME_HOME/conf/flume-kafka.conf -name agentkafka -Dflume.root.logger=INFO,console
```

### 复制文件操作
```
cp $KAFKA_HOME/libs/kafka-clients-0.9.0.1.jar $FLUME_HOME/lib/
scp -r conf/flume/flume-kafka.conf root@203.12.202.66:/opt/app/flume/apache-flume-1.6.0-bin/conf/
scp out/artifacts/KafkaSink_jar/KafkaSink.jar root@203.12.202.66:/opt/app/flume/apache-flume-1.6.0-bin/lib/
scp -r /opt/app/flume/apache-flume-1.6.0-bin/conf/* hk02:/opt/app/flume/apache-flume-1.6.0-bin/conf/
scp -r /opt/app/flume/apache-flume-1.6.0-bin/conf/* hk03:/opt/app/flume/apache-flume-1.6.0-bin/conf/
scp -r /opt/app/flume/apache-flume-1.6.0-bin/conf/* hk04:/opt/app/flume/apache-flume-1.6.0-bin/conf/

scp /opt/app/flume/apache-flume-1.6.0-bin/lib/KafkaSink.jar hk02:/opt/app/flume/apache-flume-1.6.0-bin/lib/
scp /opt/app/flume/apache-flume-1.6.0-bin/lib/KafkaSink.jar hk03:/opt/app/flume/apache-flume-1.6.0-bin/lib/
scp /opt/app/flume/apache-flume-1.6.0-bin/lib/KafkaSink.jar hk04:/opt/app/flume/apache-flume-1.6.0-bin/lib/

scp /opt/app/flume/apache-flume-1.6.0-bin/lib/* hk02:/opt/app/flume/apache-flume-1.6.0-bin/lib/
scp /opt/app/flume/apache-flume-1.6.0-bin/lib/* hk03:/opt/app/flume/apache-flume-1.6.0-bin/lib/
scp /opt/app/flume/apache-flume-1.6.0-bin/lib/* hk04:/opt/app/flume/apache-flume-1.6.0-bin/lib/
```