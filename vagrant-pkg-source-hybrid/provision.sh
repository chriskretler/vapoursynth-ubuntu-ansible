#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get purge -y thunderbird libreoffice*
apt-get update
apt-get dist-upgrade -y
apt-get install -y build-essential git libass-dev python3-dev cython3 autoconf libmagick++-dev qt5-default libfftw3-dev wget yasm python3-pip libqt5websockets5-dev pkg-config libpng-dev libsndfile1-dev libxvidcore-dev libbluray-dev zlib1g-dev libopencv-dev ocl-icd-libopencl1 opencl-headers
apt-get autoremove -y
pip3 install cython pip -U

echo "trying packages instead of source for some..."
apt-get install -y libx264-148 libx264-dev

su -c "source /vagrant/install-apps.sh" vagrant
