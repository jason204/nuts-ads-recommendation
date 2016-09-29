#!/bin/bash

$ZOOKEEPER_HOME/bin/zkServer.sh start
sudo sh kafka.sh -local start