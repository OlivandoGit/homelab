#!/bin/bash
rm -r /mnt/docker_volumes/traefik/config/*
cp config/* /mnt/docker_volumes/traefik/config/
cp .env /mnt/docker_volumes/traefik/


ssh prod-01 << EOF
        if [ ! -d /var/traefik ]; then
            echo "creating /var/traefik"
            sudo mkdir -p /var/traefik
        else
            echo "clearing /var/traefik"
            sudo rm -r /var/traefik/*
        fi

        sudo touch /var/traefik/acme.json
        sudo chmod 600 /var/traefik/acme.json
EOF


docker --context prod-01 compose down
docker --context prod-01 compose up -d --force-recreate
docker --context prod-01 ps
