FROM resin/rpi-raspbian

RUN apt-get --yes update \
    && apt-get --yes upgrade

RUN apt-get --yes install \
        hostapd \
        dnsmasq

WORKDIR /root

COPY files/start.sh /root
COPY files/dhcpd.conf /etc/dhcpd.conf
COPY files/dnsmasq.conf /etc/dnsmasq.conf
COPY files/hostapd.conf /etc/hostapd/hostapd.conf
COPY files/default_hostapd /etc/default/hostapd

# NOT SURE ABOUT THIS:
RUN update-rc.d hostapd defaults

# NOT SURE ABOUT THIS:
RUN service hostapd start

ENTRYPOINT [ "/root/start.sh" ]
