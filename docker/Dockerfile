FROM ubuntu:latest

RUN apt-get update && apt-get -y install curl iproute2 net-tools sqlite3
RUN curl -O http://content.tanium.com/files/install/6.0.314.1579/taniumclient_6.0.314.1579-ubuntu16_amd64.deb
RUN dpkg -i taniumclient_6.0.314.1579-ubuntu16_amd64.deb

ADD TaniumClient /opt/Tanium/TaniumClient

ADD boot.sh /boot.sh
CMD ["bash", "boot.sh"]

