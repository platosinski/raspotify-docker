# raspotify-docker
[![](https://img.shields.io/docker/pulls/platosinski/raspotify>)](https://hub.docker.com/r/platosinski/raspotify)
[![](https://img.shields.io/docker/automated/platosinski/raspotify)](https://hub.docker.com/r/platosinski/raspotify)

You can use this container to create a Spotify Speaker at your home, but you must have a Spotify Premium account.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

## Prerequisites

* A Raspberry Pi (tested on RPi 3)
* Docker
* docker-compose

## Usage

* Create file docker-compose.yml

```yml
version: "3.3"
services:
  raspotify:
    image: platosinski/raspotify
    network_mode: host
    restart: always
    devices:
      - /dev/snd:/dev/snd
```

* More verbose example:
```yml
version: "3.3"

services:
  raspotify:
    image: platosinski/raspotify
    network_mode: host
    restart: always
    devices:
      - /dev/snd:/dev/snd
    environment:
      SPOTIFY_NAME: Raspberry Pi
      BITRATE: 320
      ENABLE_AUDIO_CACHE: 'false'
      ENABLE_NORMALIZATION: 'true'
      VERBOSE: 'true'
      INITIAL_VOLUME: 75
      ALSA_EQUALIZATION: flat
      ALSA_SOUND_LEVEL: 0.0 dB
      ALSA_DEVICE_ID: 0
```

* If you want to use pulseaudio, you may skip device mapping:
```yml
version: "3.3"
services:
  raspotify:
    image: platosinski/raspotify
    network_mode: host
    restart: always
    environment:
      DEVICE_NAME: pulse
      PULSE_SERVER: 192.168.0.2 
```

* Run ```docker-compose up -d```

* Open Spotify App and click on a speaker icon (Connect to a device)

* Select the speaker "Raspotify"

* Enjoy!


## Environment variables

| Variable name | Description | Default |
| --- | --- | --- |
| SPOTIFY_NAME | Name of this device (shown in Spotify client) | Raspotify |
| DEVICE_NAME | ALSA pcm to which the sound will be output. You can change ALSA soundcard and device with ALSA_CARD_ID and ALSA_DEVICE_ID. Use 'pulse' for pulseaudio and specify the server in PULSE_SERVER. | default |
| USER | Username to sign in with | |
| PASS | Password | |
| BITRATE | Bitrate (kbps) | 160 (from librespot) |
| ENABLE_AUDIO_CACHE | Enable caching of the audio data. | 'false' |
| ENABLE_NORMALIZATION | Enables volume normalisation for librespot | 'true' |
| INITIAL_VOLUME | Initial volume in % from 0-100. | 50 (from librespot) |
| OPTS | Additional options for librespot. See: https://github.com/librespot-org/librespot/wiki/Options | |
| VERBOSE | Print commands executed in run.sh | 'false' |
| ALSA_SOUND_LEVEL | Sound level on ALSA device. | 0.0 dB |
| ALSA_EQUALIZATION | An equalization profile name or a series of 10 space separated values from 0-100 (one for each equalizer bin). Available profile names: flat, classical, club, dance, bass, treble, live, party, pop, rock, techno. Bins example: "90 87 87 82 80 80 82 83 91 95". If you wish to interactively test the best equalization parameters, execute ```docker-compose exec raspotify alsamixer -D equal```. On the next screen play with each equalization params, get the desired bin values and set this ENV parameter accordingly as in the example above. | | 
| ALSA_CARD_ID | Soundcard number. See: https://www.alsa-project.org/wiki/Asoundrc | 0 | 
| ALSA_DEVICE_ID | Device number | 0 |
| PULSE_SERVER | Pulse server IP/hostname. See: https://wiki.archlinux.org/index.php/PulseAudio#Environment_variables | |

## Screenshots

<img src="screenshot.png" width="200" />
