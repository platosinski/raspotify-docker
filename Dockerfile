# FROM resin/rpi-raspbian
#FROM balenalib/rpi-raspbian
ARG ARCH=
FROM ${ARCH}debian:buster-slim

RUN apt-get update && \
    apt-get -y install alsa-utils libasound2-plugin-equal gettext curl apt-transport-https && \
    update-ca-certificates --fresh && \
    curl -sSL https://dtcooper.github.io/raspotify/key.asc | sudo apt-key add -v - && \
    echo 'deb https://dtcooper.github.io/raspotify raspotify main' | sudo tee /etc/apt/sources.list.d/raspotify.list && \
    sudo apt-get update && \
    sudo apt-get -y install raspotify && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN curl -sL https://dtcooper.github.io/raspotify/install.sh | sh

ENV SPOTIFY_NAME RaspotifySpeaker
ENV BACKEND_NAME 'alsa'
ENV DEVICE_NAME 'equal'
ENV ALSA_SLAVE_PCM 'plughw:0,0'
ENV ALSA_SOUND_LEVEL '100%'
ENV VERBOSE 'false'
ENV EQUALIZATION ''

COPY /asound.conf /
COPY /equalizer.sh /

COPY /startup.sh /
ENTRYPOINT /startup.sh
