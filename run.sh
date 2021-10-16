#!/bin/bash

set -xe

echo "Preparing container..."

VERBOSE_ARG=""
NAME_ARG="--name Raspotify"
BACKEND_ARG="--backend alsa"
DEVICE_ARG=""
USER_ARG=""
PASS_ARG=""
BITRATE_ARG="--bitrate 320"
CACHE_ARG="--disable-audio-cache"
NORMALIZATION_ARG=""
INITIAL_VOLUME_ARG="--initial-volume=100"

if [ "$VERBOSE" == "true" ]; then
  VERBOSE_ARG="-v"
fi

if [ "$SPOTIFY_NAME" != "" ]; then
  NAME_ARG="--name '$SPOTIFY_NAME'"
fi

if [ "$DEVICE_NAME" != "" ]; then
  DEVICE_ARG="--device $DEVICE_NAME"
fi

if [ "$USER" != "" ]; then
  USER_ARG="-u $USER"
fi

if [ "$PASS" != "" ]; then
  PASS_ARG="-p $PASS"
fi

if [ "$NORMALIZE_AUDIO" == "true" ]; then
  NORMALIZATION_ARG="--enable-normalization"
fi

if [ "$VOLUME" != "" ]; then
  INITIAL_VOLUME_ARG="--initial-volume=$VOLUME"
fi

if [ "$DEVICE_NAME" == "equal" ]; then
  if [ "$EQUALIZATION" != "" ]; then
    echo "Applying equalization $EQUALIZATION"
    /equalizer.sh "$EQUALIZATION"
  fi
fi

set +e
if [ "$ALSA_SOUND_LEVEL" != "" ]; then
  echo "Applying sound level to $ALSA_SOUND_LEVEL"
  #TODO: enhance this logic
  amixer cset numid=1 "$ALSA_SOUND_LEVEL"
  amixer cset numid=2 "$ALSA_SOUND_LEVEL"
  amixer cset numid=3 "$ALSA_SOUND_LEVEL"
  amixer cset numid=4 "$ALSA_SOUND_LEVEL"
  amixer cset numid=5 "$ALSA_SOUND_LEVEL"
  amixer cset numid=6 "$ALSA_SOUND_LEVEL"
  amixer cset numid=7 "$ALSA_SOUND_LEVEL"
  amixer cset numid=8 "$ALSA_SOUND_LEVEL"
fi
set -e

echo "Starting Raspotify..."
/usr/bin/librespot $VERBOSE_ARG $NAME_ARG $BACKEND_ARG $DEVICE_ARG $USER_ARG $PASS_ARG $BITRATE_ARG $CACHE_ARG $NORMALIZATION_ARG $INITIAL_VOLUME_ARG

