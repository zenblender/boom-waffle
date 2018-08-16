FROM resin/rpi-raspbian

RUN apt-get update && apt-get install wget -y

ARG SNAPCAST_VERSION

RUN wget https://github.com/badaix/snapcast/releases/download/v${SNAPCAST_VERSION}/snapserver_${SNAPCAST_VERSION}_armhf.deb

RUN dpkg -i --force-all snapserver_${SNAPCAST_VERSION}_armhf.deb
RUN apt-get -f install -y

RUN mkdir -p /root/.config/snapcast/

COPY files/server.json /var/lib/snapserver/server.json
COPY files/start.sh /start.sh

ENTRYPOINT ["/start.sh"]
