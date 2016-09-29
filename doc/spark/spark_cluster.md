# 金石大数据日志分析平台

## 搭建 Spark 集群

### 设置配置文件
```
# 1.配置环境配置文件
cp spark-env.sh.template spark-env.sh
vim spark-env.sh
# 加入以下内容

# Standlone Mode
export JAVA_HOME=/opt/app/java/jdk1.7.0_79
export SPARK_MASTER_IP=hk01
export SPARK_MASTER_PORT=7077
export SPARK_WORKER_CORES=8
export SPARK_WORKER_INSTANCES=3
export SPARK_WORKER_MEMORY=8g

# 2.配置工作节点
cp slaves.template slaves
vim slaves
# 加入以下内容
hk01
hk02
hk03
hk04

# 3.复制到slave机器
# cd 到 复制文件shell处
chmod +x install_spark_cluster.sh
./install_spark_cluster.sh
```

### spark集群操作
```
# 启动集群
$SPARK_HOME/sbin/start-all.sh
# 关闭集群
$SPARK_HOME/sbin/stop-all.sh
# 集群管理
http://hk01:8080/
# Job Web UI
http://hk01:4040/
```
### 开启端口
```
# cd 到 复制文件shell处
chmod +x open_port.sh
./open_port.sh
```

### 复制文件操作
```
scp out/artifacts/LogQuery_jar/LogQuery.jar root@203.12.202.66:/opt/app/spark/jars/
scp out/artifacts/KingsGameLogAnalyser_jar/KingsGameLogAnalyser.jar root@203.12.202.66:/opt/app/spark/jars
scp root@203.12.202.66:/opt/app/spark/spark-1.6.1-bin-hadoop2.6/conf/spark-env.sh conf/spark
scp -r $SPARK_HOME/conf/spark-env.sh hk02:$SPARK_HOME/conf/
scp -r $SPARK_HOME/conf/spark-env.sh hk03:$SPARK_HOME/conf/
scp -r $SPARK_HOME/conf/spark-env.sh hk04:$SPARK_HOME/conf/
```

### 提交日志分析job
```
$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.analyser.KingsGameLogAnalyser \
    --master spark://hk01:7077 \
    --deploy-mode cluster \
    --supervise \
    --packages "org.apache.spark:spark-streaming-kafka_2.10:1.6.0,redis.clients:jedis:2.8.0" \
    --executor-memory 8G --total-executor-cores 8 \
    /opt/app/spark/jars/KingsGameLogAnalyser.jar
    
$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.analyser.KingsGameLogAnalyser \
    --master spark://hk01:7077 \
    --deploy-mode cluster \
    --executor-memory 8G --total-executor-cores 8 \
    --packages "org.apache.spark:spark-streaming-kafka_2.10:1.6.0,redis.clients:jedis:2.8.0" \
    /opt/app/spark/jars/KingsGameLogAnalyser.jar
    
$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.app.LogQuery \
    --master spark://hk01:7077 \
    --jars /opt/app/spark/jars/LogQuery.jar \
    --deploy-mode cluster \
    --executor-memory 8G --total-executor-cores 8 \
    /opt/app/spark/jars/LogQuery.jar
    
$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.app.LogQuery \
    --master spark://hk01:7077 \
    --jars /opt/app/spark/jars/LogQuery.jar \
    --executor-memory 8G --total-executor-cores 8 \
    /opt/app/spark/jars/LogQuery.jar
    
$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.analyser.KingsGameLogAnalyser \
    --master spark://nopromdeMacBook-Pro.local:7077 \
    --deploy-mode cluster \
    --executor-memory 6G --total-executor-cores 4 \
    --packages "org.apache.spark:spark-streaming-kafka_2.10:1.6.0,redis.clients:jedis:2.8.0" \
    /Users/noprom/Documents/Dev/Spark/Pro/KingsGameLogPlatform/out/artifacts/KingsGameLogAnalyser_jar/KingsGameLogAnalyser.jar \
    spark://nopromdeMacBook-Pro.local:7077 \
    localhost:9092, localhost:9093, localhost:9094 \
    /Users/noprom/Desktop/opt/data
```

### 停止spark job
```
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.Client kill <master url> <driver ID>
$SPARK_HOME/bin/spark-class org.apache.spark.deploy.Client kill spark://hk01:7077 worker-20160322162428-10.254.131.4-62643
```