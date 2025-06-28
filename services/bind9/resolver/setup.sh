#!/bin/bash

#List of ssh clients for my core servers (as defined in my ssh config file)
vms=("core-01" "core-02")

for i in "${vms[@]}"
do
    echo "====================================================="
    echo $i
    echo "====================================================="

    scp -r config $i:~

    ssh $i << EOF
        if [ ! -d /etc/bind/resolver ]; then
            sudo mkdir /etc/bind/resolver
        else
            sudo rm -r /etc/bind/resolver/*
        fi

        if [ ! -d /var/bind/authoratatiive ]; then
            sudo mkdir -p /var/bind/resolver
        else
            sudo rm -r /var/bind/resolver/*
        fi

        sudo mv ~/config/* /etc/bind/resolver/named.conf
        sudo rm -r ~/config

        #Turn off the DNSStubListener for this VM
        sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
        sudo systemctl restart systemd-resolved.service

EOF

    docker --context $i compose down
    docker --context $i compose up -d
    docker --context $i ps

done

