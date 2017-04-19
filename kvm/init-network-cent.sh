#!/bin/bash

#==========================================
Usage="Usage: init-network-cent.sh {hostname} {natIP} {bridgeIP}"
#==========================================

if [ $# -ne 3 ]; then
    echo $Usage
    exit
fi

hostname=$1
natIP=$2
bridgeIP=$3

echo "hostname: "$hostname
echo "natIP   : "$natIP
echo "bridgeIP: "$bridgeIP


#==========================================
# set hostname
#==========================================

hostnamectl set-hostname $hostname


#==========================================
# set localIP
#==========================================
natIP=$natIP"/24"
gateway="192.168.122.1"

nmcli c modify eth0 ipv4.addresses ${natIP}
nmcli c modify eth0 ipv4.gateway $gateway
nmcli c modify eth0 ipv4.dns $gateway
nmcli c modify eth0 ipv4.method manual

# restart
nmcli c down eth0
nmcli c up eth0

#==========================================
# set hostname
#==========================================
#==========================================
# set hostname
#==========================================

systemctl restart network
