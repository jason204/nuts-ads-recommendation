#!/bin/sh

host=(hk02 hk03 hk04)

for h in ${host[@]}; do
	scp -r /etc/sysconfig/iptables $h:/etc/sysconfig/iptables
	ssh $h "service iptables restart"
done