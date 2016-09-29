#!/bin/bash

if [ $# -ne 1 ];
then
    echo "`basename ${0}`:usage: [start] | [stop] | [status] | [log]"
	exit 1
fi
option=$1
case ${option} in
    start)
        salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh start"
        ;;
    stop)
        salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh stop"
        ;;
    status)
        salt "*" cmd.run "$ZOOKEEPER_HOME/bin/zkServer.sh status"
        ;;
    log)
        salt "*" cmd.run "cat $ZOOKEEPER_HOME/zookeeper.out"
        ;;
    *)
        echo "`basename ${0}`:usage: [start] | [stop] | [status] | [log]"
	    exit 1
esac