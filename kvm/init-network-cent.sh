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
# set natIP
#==========================================
gateway="192.168.122.1"

nmcli c modify eth0 ipv4.addresses ${natIP}"/24"
nmcli c modify eth0 ipv4.gateway $gateway
nmcli c modify eth0 ipv4.dns $gateway
nmcli c modify eth0 ipv4.method manual

# restart
nmcli c down eth0
nmcli c up eth0

#==========================================
# set bridgeIP
#==========================================
gateway="10.0.0.1"

nmcli c modify '有線接続 1' connection.id eth1
nmcli c modify eth1 ipv4.addresses ${bridgeIP}"/16"
nmcli c modify eth1 ipv4.gateway $gateway
nmcli c modify eth1 ipv4.dns $gateway
nmcli c modify eth1 ipv4.method manual
nmcli c modify eth1 ipv4.dns-search lan.example.jp

# restart
nmcli c down eth1
nmcli c up eth1

systemctl restart network
