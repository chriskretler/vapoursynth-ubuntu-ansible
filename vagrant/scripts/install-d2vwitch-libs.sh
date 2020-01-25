#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get update
apt-get install -y git autoconf automake libtool pkg-config build-essential libavformat-dev libavcodec-dev qt5-default

# d2vwitch requires ffmpeg 3.4
# ubuntu 16.04 provides 2.8
# ubuntu 18.04 provides 3.4
