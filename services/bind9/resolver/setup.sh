#!/bin/bash

#List of ssh clients for my core servers (as defined in my ssh config file)
vms=("core-01" "core-02")

rm -r /mnt/docker_volumes/bind9-resolver/config/*
cp config/* /mnt/docker_volumes/bind9-resolver/config/

for i in "${vms[@]}"
do
    echo "====================================================="
    echo $i
    echo "====================================================="

    ssh $i << EOF
        #Turn off the DNSStubListener for this VM
        sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
        sudo systemctl restart systemd-resolved.service

EOF

    docker --context $i compose down
    docker --context $i compose up -d
    docker --context $i ps

done

