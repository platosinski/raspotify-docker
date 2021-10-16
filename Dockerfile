ARG ARCH=
FROM ${ARCH}debian:buster-slim

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -fsSL https://dtcooper.github.io/raspotify/key.asc | gpg --dearmor --yes -o /usr/share/keyrings/raspotify-archive-keyring.gpg && \
    echo 'deb [arch=armhf signed-by=/usr/share/keyrings/raspotify-archive-keyring.gpg] https://dtcooper.github.io/raspotify raspotify main' > /etc/apt/sources.list.d/raspotify.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      alsa-utils libasound2-plugins libasound2-plugin-equal gettext \
      raspotify && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV VERBOSE 'false'
ENV DEVICE_NAME ''
ENV USER ''
ENV PASS ''
ENV ALSA_SLAVE_PCM ''
ENV ALSA_SOUND_LEVEL ''
ENV EQUALIZATION ''
ENV NORMALIZE_AUDIO 'false'

COPY asound.conf /etc/asound.conf
COPY equalizer.sh /equalizer.sh
COPY run.sh /run.sh

CMD ["/run.sh"]
