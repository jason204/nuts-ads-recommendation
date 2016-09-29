#!/bin/bash
help_msg="usage: [pull]"
if [ $# -ne 1 ];
then
    echo "`basename ${0}`:$help_msg"
	exit 1
fi
option=$1
case $option in
    pull)
    salt '*' cmd.run 'cd /opt/app/KingsGameLogPlatform/ && git pull origin master'
    ;;
    *)
    echo "`basename ${0}`:$help_msg"
	exit 1
    ;;
esac