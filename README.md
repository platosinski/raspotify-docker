# rpi-spotify
[<img src="https://img.shields.io/docker/pulls/flaviostutz/rpi-spotify"/>](https://hub.docker.com/r/flaviostutz/rpi-spotify)
[<img src="https://img.shields.io/docker/automated/flaviostutz/rpi-spotify"/>](https://hub.docker.com/r/flaviostutz/rpi-spotify)

[![](https://images.microbadger.com/badges/version/flaviostutz/rpi-spotify.svg)](https://microbadger.com/images/flaviostutz/rpi-spotify "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/flaviostutz/rpi-spotify.svg)](https://microbadger.com/images/flaviostutz/rpi-spotify "Get your own image badge on microbadger.com")

You can use this container to create a Spotify Speaker at your home, but you must have a Spotify Premium account.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.
This docker container image leverages the work from [David Cooper](https://dtcooper.github.io/raspotify).

For more info on configuring your Raspberry Pi for this to work, go to https://github.com/flaviostutz/ambience-sound

## Prerequisites

* A Raspberry Pi (tested on RPi2/3)
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

* If you want to use ALSA equalizer:
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
      - DEVICE_NAME=equal
      - EQUALIZATION=rock
```

* If you want to use pulseaudio without ALSA equalizer:
```yml
version: "3.3"
services:
  raspotify:
    image: platosinski/raspotify
    network_mode: host
    restart: always
    environment:
      - DEVICE_NAME=pulse
      - PULSE_SERVER=127.0.0.1
```

* If you want to use pulseaudio with ALSA equalizer:
```yml
version: "3.3"
services:
  raspotify:
    image: platosinski/raspotify
    network_mode: host
    restart: always
    environment:
      - DEVICE_NAME=equal
      - EQUALIZATION=rock
      - ALSA_SLAVE_PCM=plug:pulse
      - PULSE_SERVER=127.0.0.1
```

* Run ```docker-compose up -d```

* Open Spotify App and click on a speaker icon (Connect to a device)

* Select the speaker "MyHouse"

* Enjoy!


## ENVs

* SPOTIFY_NAME: Specifies the name of this speaker (shown in Spotify client)

* DEVICE_NAME: PCM output io device to which the sound will be output using ALSA.
Defaults to 'plughw:0,0' so that you can run this image with minimum configuration.
Use 'equal' for equalization and configure the target hw using "ALSA_SLAVE_PCM" (defaults to 'plughw:0,0').
Use 'pulse' for pulseaudio and specify the server in PULSE_SERVER.

* ALSA_SLAVE_PCM: slave device as configured in alsa to which the sound will be sent to. eg. use 'plughw:0,0' for device at card 0, sub 0"

* ALSA_SOUND_LEVEL: overall sound level on ALSA output. defaults to 100% so that usb sound noises are reduced because there will be needed less amplification

* EQUALIZATION: an equalization profile name or a series of 10 space separated values from 0-100 (one for each equalizer bin)
  * profile names: flat, classical, club, dance, bass, treble, live, party, pop, rock, techno
  * bins example: "90 87 87 82 80 80 82 83 91 95"
  * if you wish to interactively test the best equalization parameters, execute ```docker-compose exec raspotify alsamixer -D equal```. On the next screen play with each equalization params, get the desired bin values and set this ENV parameter accordingly as in the example above

* PULSE_SERVER Defines where the pulse server is. See: https://wiki.archlinux.org/index.php/PulseAudio/Configuration

## Screenshots

<img src="screenshot.png" width="200" />
