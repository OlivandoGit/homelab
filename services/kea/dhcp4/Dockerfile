FROM debian:latest

RUN apt update && apt install curl gnupg apt-transport-https -y
RUN curl -1sLf 'https://dl.cloudsmith.io/public/isc/kea-2-6/setup.deb.sh' | bash
RUN apt update && apt install isc-kea-dhcp4-server isc-kea-hooks -y

EXPOSE 67/udp

CMD ["/usr/sbin/kea-dhcp4", "-c", "/etc/kea/kea-dhcp4.conf"]

