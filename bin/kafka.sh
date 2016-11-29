#!/bin/bash

if [ $# -ne 2 ];
then
    echo "`basename ${0}`:usage: "
    echo "-local"
    echo "      start | stop | consume | list | delete | describe"
    echo "-cluster"
    echo "      start | stop | consume"
	exit 1
fi
option=$1
action=$2
zookeeper_cluster=localhost:2181/kafka
topic=log-topic
case ${option} in
    -local)
        if [ ${action} == 'start' ];
            then
                exec sudo ${KAFKA_HOME}/bin/zookeeper-server-start.sh ${KAFKA_HOME}/config/zookeeper.properties &
                exec sudo ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server.properties &
                exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server-1.properties &
                exec ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server-2.properties &
                exec ${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${zookeeper_cluster} --create --replication-factor 1 --partitions 1 --topic ${topic} &
        elif [ ${action} == 'stop' ]
            then
                exec sudo ${KAFKA_HOME}/bin/zookeeper-server-stop.sh &
                exec sudo ${KAFKA_HOME}/bin/kafka-server-stop.sh ${KAFKA_HOME}/config/server.properties &
                exec sudo ${KAFKA_HOME}/bin/kafka-server-stop.sh ${KAFKA_HOME}/config/server-1.properties &
                exec sudo ${KAFKA_HOME}/bin/kafka-server-stop.sh ${KAFKA_HOME}/config/server-2.properties &
        elif [ ${action} == 'consume' ]
            then
                exec sudo ${KAFKA_HOME}/bin/kafka-console-consumer.sh --zookeeper ${zookeeper_cluster} --topic log-topic --from-beginning
        elif [ ${action} == 'list' ]
            then
                exec sudo ${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${zookeeper_cluster} --list
        elif [ ${action} == 'delete' ]
            then
                exec sudo ${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${zookeeper_cluster} --delete --topic ${topic}
        elif [ ${action} == 'describe' ]
            then
                exec sudo ${KAFKA_HOME}/bin/kafka-topics.sh --zookeeper ${zookeeper_cluster} --describe --topic ${topic}
        fi
        ;;
    -cluster)
        # TODO:主机列表
        host=(hk01 hk02 hk03)
        if [ ${action} == 'start' ];
            then
                for h in ${host[@]}; do
                    exec sudo ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_HOME}/config/server-$h.properties
                done
                # 最后创建一个topic
                exec sudo ${KAFKA_HOME}/bin/kafka-topics.sh --create --zookeeper hk01:2181,hk02:2181,hk03:2181/kafka --replication-factor 4 --partitions 2 --topic log-topic
        elif [ ${action} == 'stop' ]
            then
                for h in ${host[@]}; do
                    exec sudo ${KAFKA_HOME}/bin/kafka-server-stop.sh ${KAFKA_HOME}/config/server-$h.properties
                done
        elif [ ${action} == 'consume' ]
            then
                exec sudo ${KAFKA_HOME}/bin/kafka-console-consumer.sh --zookeeper hk01:2181,hk02:2181,hk03:2181/kafka --topic log-topic --from-beginning
        fi
        ;;
    *)
        echo "`basename ${0}`:usage: [-local start] | [-local stop] | [-local consume] | [-cluster start] | [-cluster stop]"
	    exit 1
esac