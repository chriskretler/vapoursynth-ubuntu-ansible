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

echo "Build NASM"
cd /home/chris/installs/nasm \
	&& ./configure --prefix=/usr \
	&& make \
	&& sudo make install

echo "Build l-smash"
# 1/5/2019: added specific tag
cd /home/chris/installs/l-smash \
	&& git checkout tags/v2.14.5 \
	&& ./configure --enable-shared \
	&& make lib \
	&& make install-lib

echo "Build x264"
# 1/5/2019: switch to stable branch
cd /home/chris/installs/x264 \
	&& git checkout stable \
	&& ./configure --enable-shared \
	&& make \
	&& make install

echo "Build ffmpeg"
# was originally 3.3.4
cd /home/chris/installs/ffmpeg \
	&& git checkout tags/n3.4.5 \
	&& ./configure --enable-gpl --enable-libx264 --enable-avresample --enable-shared \
	&& make \
	&& make install

echo "Build zimg"
# 1/5/2019: was release-2.6.3
cd /home/chris/installs/zimg \
	&& git checkout tags/release-2.8 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

echo "Build Vapoursynth"
cd /home/chris/installs/vapoursynth \
	&& git checkout tags/R45.1 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& mkdir -p /home/chris/.config/vapoursynth \
	&& echo 'export PYTHONPATH=/usr/local/lib/python3.5/site-packages/' | tee --append /home/chris/.bashrc \
	&& echo 'UserPluginDir=/usr/local/lib' | tee --append /home/chris/.config/vapoursynth/vapoursynth.conf \
	&& make install \
	&& echo 'include /usr/local/lib' | tee --append /etc/ld.so.conf \
	&& ldconfig

echo "Build Vapoursynth-Editor"
cd /home/chris/installs/vapoursynth-editor \
	&& git checkout tags/r18 \
	&& cd pro \
	&& qmake -norecursive pro.pro CONFIG+=release \
	&& make \
	&& mkdir /home/chris/Applications \
	&& mv ../build/release-64bit-gcc /home/chris/Applications/VapourSynth-Editor \
	&& ln -s home/chris/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

echo "Build vapoursynth-extra-plugins"
cd /home/chris/installs/vapoursynth-plugins \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

echo "Build MVMulti"
# MVMulti - r7 is the last tag to not require c++ 17.
# This won't be available in gcc until Ubuntu 17.10.
cd /home/chris/installs/vapoursynth-mvtools-sf \
	&& git checkout tags/r7 \
	&& chmod +x autogen.sh \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

echo "clone mxDnCnn"
