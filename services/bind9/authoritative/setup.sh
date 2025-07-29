#!/bin/bash

vms=("core-01" "core-02")

for i in "${vms[@]}"
do
    echo "====================================================="
    echo $i
    echo "====================================================="

    scp -r config $i:~

    ssh $i << EOF
        if [ ! -d /etc/bind/authoritative ]; then
            echo "creating /etc/bind/authoritative"
            sudo mkdir -p /etc/bind/authoritative
        else
            echo "clearing /etc/bind/authoritative"
            sudo rm -r /etc/bind/authoritative/*
        fi

        if [ ! -d /var/bind/authoritative ]; then
            echo "creating /var/bind/authoritative"
            sudo mkdir -p /var/bind/authoritative
        else
            echo "clearing /var/bind/authoritative"
            sudo rm -r /var/bind/authoritative/*
        fi

        sudo mv ~/config/.$i.named.conf /etc/bind/authoritative/named.conf
        sudo mv ~/config/[^.]* /var/bind/authoritative

        sudo rm -r ~/config

        sudo sed -i 's/#DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
        sudo systemctl restart systemd-resolved.service

EOF
    docker --context $i compose down
    docker --context $i compose up -d
    docker --context $i ps
done

