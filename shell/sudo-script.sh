#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

echo "Updating Ubuntu and Python libraries..."
apt-get purge -y thunderbird libreoffice*
apt-get update
apt-get dist-upgrade -y
apt-get install -y build-essential git libass-dev python3-dev cython3 autoconf libmagick++-dev qt5-default libfftw3-dev wget yasm python3-pip libqt5websockets5-dev pkg-config libpng-dev libsndfile1-dev libxvidcore-dev libbluray-dev zlib1g-dev libopencv-dev ocl-icd-libopencl1 opencl-headers
apt-get autoremove -y

# Create the chris user
useradd -m -s /bin/bash -U chris

# run the install-apps script as chris.
su -c "source ./user-script.sh" chris

echo "Install NASM"
cd ~/installs/nasm \
	&& make install

echo "Install l-smash"
cd ~/installs/l-smash \
	&& make install-lib

echo "Install x264"
cd ~/installs/x264 \
	&& make install

echo "Install ffmpeg"
# was originally 3.3.4
cd ~/installs/ffmpeg \
	&& make install

echo "Install zimg"
cd ~/installs/zimg \
	&& make install

echo "Install Vapoursynth"
cd ~/installs/vapoursynth \
	&& make install \
	&& echo 'include /usr/local/lib' | tee --append /etc/ld.so.conf \
	&& ldconfig

echo "Install Vapoursynth-Editor"
cd ~/Applications \
	&& ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

echo "Install vapoursynth-extra-plugins"
cd ~/installs/vapoursynth-plugins \
	&& make install

echo "Install MVMulti"
cd ~/installs/vapoursynth-mvtools-sf \
	&& make install


