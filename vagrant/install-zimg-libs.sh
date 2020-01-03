#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get update
apt-get install -y autoconf automake libtool pkg-config build-essential python3-dev python-pip git
