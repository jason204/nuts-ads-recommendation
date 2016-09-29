#!/bin/bash

help_msg="usage: [local] | [cluster]"
if [ $# -ne 1 ];
then
    echo "`basename ${0}`:$help_msg"
	exit 1
fi
option=$1
if [ ${option} == 'cluster' ]; then
    java -jar /opt/app/KingsGameLogPlatform/lib/LogGenerator.jar /opt/app/data
elif [ ${option} == 'local'  ]
then
    java -jar /Users/noprom/Documents/Dev/Spark/Pro/KingsGameLogPlatform/lib/LogGenerator.jar /Users/noprom/Downloads/opt/event
fi