#!/bin/sh

host=(hk02 hk03)

for h in ${host[@]}; do
	ssh $h "echo NETWORKING=yes>/etc/sysconfig/network"
	ssh $h "echo HOSTNAME=$h>>/etc/sysconfig/network"
	ssh $h "hostname $h"
	ssh $h "echo $HOSTNAME"
	ssh $h "echo master: hk01>/etc/salt/minion"
	ssh $h "echo id: $h>>/etc/salt/minion"
	ssh $h "service salt-minion restart"
	
	scp -r /wwwroot/event/ $h:/wwwroot/
	scp -r /etc/hosts $h:/etc/
	scp -r /etc/nginx/ $h:/etc/
done
