#!/bin/bash

# configure network
echo NETWORKING=yes>/etc/sysconfig/network
echo HOSTNAME=hk01>>/etc/sysconfig/network
echo 106.3.132.139 hk01 >> /etc/hosts
echo 106.3.132.142 hk02 >> /etc/hosts
echo 106.3.132.144 hk03 >> /etc/hosts

# salt stack
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh -M