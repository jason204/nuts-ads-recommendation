#!/bin/sh

host=(hk02 hk03 hk04)

for h in ${host[@]}; do
    scp -r /opt/app/flume/apache-flume-1.6.0-bin/conf/* $h:/opt/app/flume/apache-flume-1.6.0-bin/conf/
done