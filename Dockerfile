FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg && \
    curl -kfsSL https://dtcooper.github.io/raspotify/key.asc | gpg --dearmor --yes -o /usr/share/keyrings/raspotify-archive-keyring.gpg && \
    echo 'deb [signed-by=/usr/share/keyrings/raspotify-archive-keyring.gpg] https://dtcooper.github.io/raspotify raspotify main' > /etc/apt/sources.list.d/raspotify.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      alsa-utils libasound2-plugins libasound2-plugin-equal gettext \
      raspotify && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV SPOTIFY_NAME 'Raspotify'
ENV DEVICE_NAME 'default'
ENV USER ''
ENV PASS ''
ENV BITRATE ''
ENV ENABLE_AUDIO_CACHE 'false'
ENV ENABLE_NORMALIZATION 'true'
ENV INITIAL_VOLUME ''
ENV OPTS ''
ENV VERBOSE 'false'
ENV ALSA_EQUALIZATION ''
ENV ALSA_SOUND_LEVEL '0.0 dB'
ENV ALSA_CARD_ID 0
ENV ALSA_DEVICE_ID 0
ENV _ALSA_EQUAL_SLAVE_PCM 'default'

COPY asound.conf /etc/asound.conf
COPY equalizer.sh /equalizer.sh
COPY run.sh /run.sh

CMD ["/run.sh"]
