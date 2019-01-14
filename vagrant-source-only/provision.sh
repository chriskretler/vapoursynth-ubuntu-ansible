#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get purge -y thunderbird libreoffice*
apt-get update
apt-get dist-upgrade -y
apt-get install -y build-essential git libass-dev python3-dev cython3 autoconf libmagick++-dev qt5-default libfftw3-dev wget yasm python3-pip libqt5websockets5-dev pkg-config libpng-dev libsndfile1-dev libxvidcore-dev libbluray-dev zlib1g-dev libopencv-dev ocl-icd-libopencl1 opencl-headers
apt-get autoremove -y
pip3 install cython pip --user -U

# Create the chris user
useradd -m -s /bin/bash -U chris

# run the install-apps script as chris.
su -c "source /vagrant/install-apps.sh" vagrant
