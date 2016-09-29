#!/bin/bash
# +----------------+
# |      flume     |
# +----------------+

exec $FLUME_HOME/bin/flume-ng agent --conf $FLUME_HOME/conf --conf-file $FLUME_HOME/conf/flume-kafka.conf -name agentkafka -Dflume.root.logger=INFO,console