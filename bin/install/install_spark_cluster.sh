#!/bin/sh

host=(hk02 hk03 hk04)

for h in ${host[@]}; do
    scp -r /opt/app/spark/spark-1.6.1-bin-hadoop2.6/conf/* $h:/opt/app/spark/spark-1.6.1-bin-hadoop2.6/conf/
done