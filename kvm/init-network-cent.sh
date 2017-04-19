#!/bin/bash

#==========================================
Usage="Usage: init-network-cent.sh {hostname} {NATIP} {bridgeIP}"
#==========================================

if [ $# -ne 3 ]; then
    echo $Usage
    exit
fi

hostname=$1
localIP=$2
globalIP=$3

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

nmcli c mod eth1 ipv4.method manual
nmcli c mod eth1 ipv4.address "${natIP}"/24
nmcli c mod eth1 ipv4.gateway "192.168.122.255"
nmcli c mod eth1 ipv4.dns "192.168.122.1"

# restart
nmcli c down eth0
nmcli c up eth0

#==========================================
# set hostname
#==========================================
#==========================================
# set hostname
#==========================================
