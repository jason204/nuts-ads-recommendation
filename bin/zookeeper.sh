#!/bin/bash

if [ $# -ne 2 ];
then
    echo "`basename ${0}`:usage: [-local start] | [-local stop] | [-local status] | [-local log] | [-cluster start] | [-cluster stop] | [-cluster status]"
	exit 1
fi
option=$1
action=$2
case ${option} in
    -local)
        if [ ${action} == 'start' ];
            then
                exec sudo $ZOOKEEPER_HOME/bin/zkServer.sh start
        elif [ ${action} == 'stop' ]
            then
                exec sudo $ZOOKEEPER_HOME/bin/zkServer.sh stop
        elif [ ${action} == 'status' ]
            then
                exec sudo $ZOOKEEPER_HOME/bin/zkServer.sh status
        elif [ ${action} == 'log' ]
        then
            exec sudo cat $ZOOKEEPER_HOME/zookeeper.out
        fi
        ;;
    -cluster)
        if [ ${action} == 'start' ];
            then
                salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh start"
        elif [ ${action} == 'stop' ]
            then
                salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh stop"
        elif [ ${action} == 'status' ]
            then
                salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh status"
        fi
        ;;
    *)
        echo "`basename ${0}`:usage: [-local start] | [-local stop] | [-local status] | [-local log] | [-cluster start] | [-cluster stop] | [-cluster status]"
	    exit 1
esac