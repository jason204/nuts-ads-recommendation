#!/bin/bash

if [ $# -ne 2 ];
then
    echo "`basename ${0}`:usage: [-local process] | [-local query <query params>] | [-cluster process] | [-cluster query <query params>]"
	exit 1
fi
option=$1
action=$2
param=$3
case ${option} in
    -local)
        if [ ${action} == 'process' ];
            then
                exec
                "$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.process.KingsGameLogProcessor \\
                --master spark://nopromdeMacBook-Pro.local:7077 \\
                --executor-memory 6G --total-executor-cores 4 \\
                --packages 'org.apache.spark:spark-streaming-kafka_2.10:1.6.0,redis.clients:jedis:2.8.0' \\
                /Users/noprom/Documents/Dev/Spark/Pro/KingsGameLogPlatform/out/artifacts/KingsGameLogProcessor_jar/KingsGameLogProcessor.jar \\
                'local[4]' 'localhost:9092, localhost:9093, localhost:9094' /Users/noprom/Desktop/opt/data"
        elif [ ${action} == 'query' ]
            then
                exec
                "$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.app.KingsGameLogQuery \
                --master spark://nopromdeMacBook-Pro.local:7077 \
                --executor-memory 6G --total-executor-cores 4 \
                /Users/noprom/Documents/Dev/Spark/Pro/KingsGameLogPlatform/out/artifacts/KingsGameLogQuery_jar/KingsGameLogQuery.jar \
                $3"
        fi
        ;;
    -cluster)
        if [ ${action} == 'process' ];
            then
                exec
                "$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.process.KingsGameLogProcessor \\
                --master spark://hk01:7077 \\
                --executor-memory 8G --total-executor-cores 4 \\
                --packages 'org.apache.spark:spark-streaming-kafka_2.10:1.6.0,redis.clients:jedis:2.8.0' \\
                /opt/app/KingsGameLogPlatform/lib/KingsGameLogProcessor.jar"
        elif [ ${action} == 'query' ]
            then
                exec
                "$SPARK_HOME/bin/spark-submit --class cn.kingsgame.log.app.KingsGameLogQuery \\
                --master spark://hk01:7077 \\
                --executor-memory 8G --total-executor-cores 4 \\
                /opt/app/KingsGameLogPlatform/lib/KingsGameLogQuery.jar \\
                $3"
        fi
        ;;
    *)
        echo "`basename ${0}`:usage: [-local process] | [-local query <query params>] | [-cluster process] | [-cluster query <query params>]"
	    exit 1
esac