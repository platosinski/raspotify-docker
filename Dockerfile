# FROM resin/rpi-raspbian
#FROM balenalib/rpi-raspbian
ARG ARCH=
FROM ${ARCH}debian:buster

#raspotify install
RUN apt-get update && \
    apt-get -y install gnupg2 alsa-utils libasound2-plugin-equal gettext curl apt-transport-https && \
    update-ca-certificates --fresh && \
    curl -skSL https://dtcooper.github.io/raspotify/key.asc | apt-key add -v - && \
    echo 'deb https://dtcooper.github.io/raspotify raspotify main' | tee /etc/apt/sources.list.d/raspotify.list && \
    apt-get update && \
    apt-get -y install raspotify && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 9003 spotify && useradd -u 9003 -r -g spotify spotify && usermod -a -G audio spotify

ENV SPOTIFY_NAME RaspotifySpeaker
ENV USER ''
ENV PASS ''
ENV BACKEND_NAME 'alsa'
ENV DEVICE_NAME 'equal'
ENV ALSA_SLAVE_PCM 'plughw:0,0'
ENV ALSA_SOUND_LEVEL '100%'
ENV VERBOSE 'false'
ENV EQUALIZATION ''

COPY /asound.conf /etc/asound.conf
COPY --chown=spotify:spotify /equalizer.sh /

COPY --chown=spotify:spotify /startup.sh /
ENTRYPOINT /startup.sh
