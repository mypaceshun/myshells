#!/bin/bash


#============================
Usage="Usage: my-virt-clone.sh {original image name} {new image name} "
#============================

if [ $# -eq 1 ]; then
    org="org"
    new=$1
elif [ $# -eq 2 ]; then
    org=$1
    new=$2
else
    echo $Usage
    exit
fi

echo "org: "$org
echo "new: "$new

#============================
# clone image
#============================

org_status=`virsh domstate $org`
if [ ${org_status} = "実行中" ]; then
    virsh shutdown $org
fi

# shutdown wait...
sleep 5

virt-clone \
--original $org \
--name $new \
--file /var/lib/libvirt/images/${new}.img \
--check path_exists=off

virsh start $new
virsh autostart $new


