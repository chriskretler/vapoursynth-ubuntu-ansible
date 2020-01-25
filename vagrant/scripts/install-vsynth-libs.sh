#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get update
apt-get install -y autoconf automake libtool pkg-config build-essential python3-dev python3-pip git cython3

# cython3 needed for vsynth 
su -c "pip3 install --upgrade cython" vagrant
