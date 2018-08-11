FROM resin/rpi-raspbian

RUN apt-get update && apt-get install wget -y

ARG SNAPCAST_VERSION

RUN wget https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapclient_${SNAPCAST_VERSION}_armhf.deb

RUN dpkg -i --force-all snapclient_${SNAPCAST_VERSION}_armhf.deb
RUN apt-get -f install -y

RUN apt-get update && apt-get install alsa-base alsa-utils -y

COPY files/start.sh /start.sh

ENTRYPOINT ["/start.sh"]
