#!/bin/sh

host=(hk02 hk03 hk04)

for h in ${host[@]}; do
    scp -r /etc/profile $h:/etc/
    scp -r /opt/app $h:/opt/
    ssh $h "source /etc/profile"
done