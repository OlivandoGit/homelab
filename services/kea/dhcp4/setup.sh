#!/bin/bash

vms=("core-01" "core-02")

for i in "${vms[@]}"
do
    echo "====================================================="
    echo $i
    echo "====================================================="

    scp config/$i/kea-dhcp4.conf $i:~

    ssh $i << EOF
        if [ ! -d /etc/kea ]; then
            echo "creating /etc/kea"
            sudo mkdir -p /etc/kea
        else
            echo "clearing /etc/kea"
            sudo rm -r /etc/kea/*
        fi

        sudo mv ~/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf

EOF
    docker --context $i build -t kea_dhcp4 .
    docker --context $i compose down
    docker --context $i compose up -d
    docker --context $i ps
done

