FROM resin/rpi-raspbian

RUN apt-get --yes update \
    && apt-get --yes upgrade \
    && apt-get --yes install \
        build-essential \
        git \
        xmltoman \
        autoconf \
        automake \
        libtool \
        libdaemon-dev \
        libpopt-dev \
        libconfig-dev \
        libasound2-dev \
        avahi-daemon \
        libavahi-client-dev \
        libssl-dev \
        libnss-mdns

WORKDIR /root

RUN git clone https://github.com/mikebrady/shairport-sync.git shairport-sync \
    && cd shairport-sync \
    && autoreconf -fi \
    && ./configure --sysconfdir=/etc --with-alsa --with-avahi --with-ssl=openssl --with-systemd --with-pipe \
    && make \
    && make install

COPY start-shairport-sync.sh /root

ENTRYPOINT [ "/root/start-shairport-sync.sh" ]
