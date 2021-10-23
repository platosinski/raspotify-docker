#!/bin/bash

set -e
if [ "$VERBOSE" == "true" ]; then
  set -x
fi

echo "Preparing container..."

if [ "$ALSA_SOUND_LEVEL" != "" ]; then
  echo "Applying sound level to $ALSA_SOUND_LEVEL"
  amixer -D $DEVICE_NAME cset numid=1 "$ALSA_SOUND_LEVEL"
fi

if [ "$ALSA_EQUALIZATION" != "" ]; then
  _ALSA_EQUAL_SLAVE_PCM="$DEVICE_NAME"
  DEVICE_NAME=equal
  echo "Applying equalization '$ALSA_EQUALIZATION'"
  /equalizer.sh "$ALSA_EQUALIZATION"
fi

PARAMS=()

if [ "$SPOTIFY_NAME" == "" ]; then
  SPOTIFY_NAME=Raspotify
fi
PARAMS+=(--name "$SPOTIFY_NAME")

PARAMS+=(--backend alsa)

if [ "$DEVICE_NAME" != "" ]; then
  PARAMS+=(--device $DEVICE_NAME)
fi

if [ "$USER" != "" ]; then
  PARAMS+=(--user $USER)
fi

if [ "$PASS" != "" ]; then
  PARAMS+=(--password $PASS)
fi

if [ "$BITRATE" != "" ]; then
  PARAMS+=(--bitrate $BITRATE)
fi

if [ "$ENABLE_AUDIO_CACHE" != "true" ]; then
  PARAMS+=(--disable-audio-cache)
fi

if [ "$ENABLE_NORMALIZATION" == "true" ]; then
  PARAMS+=(--enable-volume-normalisation)
fi

if [ "$INITIAL_VOLUME" != "" ]; then
  PARAMS+=(--initial-volume $INITIAL_VOLUME)
fi

echo "Starting Raspotify..."
/usr/bin/librespot "${PARAMS[@]}" $OPTS

