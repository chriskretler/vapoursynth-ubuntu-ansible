#!/bin/bash -x

# 4/19/2018: include nnedi3cl when I figure out what version of boost is required.
# https://forum.doom9.org/showthread.php?p=1839813#post1839813
# https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL

# 4/19/2018: include myrosilk's fft3d update when ubuntu 18.04 is out, which will
# provide an updated gcc version
# https://github.com/myrsloik/VapourSynth-FFT3DFilter

pip3 install cython pip --user -U

echo "Downloading source code..."
mkdir ~/installs
cd ~/installs
git clone https://github.com/l-smash/l-smash.git
git clone git://git.videolan.org/x264.git
git clone https://github.com/ffmpeg/ffmpeg.git
git clone https://github.com/sekrit-twc/zimg.git
git clone https://github.com/vapoursynth/vapoursynth.git
git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
git clone https://github.com/darealshinji/vapoursynth-plugins
git clone https://github.com/IFeelBloated/vapoursynth-mvtools-sf
git clone https://github.com/kice/vs_mxDnCNN

echo "Build NASM"
# Required for x264
# 1/5/2019: updated version
# was http://www.nasm.us/pub/nasm/releasebuilds/2.13.01/nasm-2.13.01.tar.xz
mkdir ~/installs/nasm \
	&& cd ~/installs/nasm \
	&& wget http://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.xz \
	&& tar -xf nasm-2.14.02.tar.xz --strip-components=1 \
	&& ./configure --prefix=/usr \
	&& make

echo "Build l-smash"
# 1/5/2019: added specific tag
cd ~/installs/l-smash \
	&& git checkout tags/v2.14.5 \
	&& ./configure --enable-shared \
	&& make lib

echo "Build x264"
# 1/5/2019: switch to stable branch
cd ~/installs/x264 \
	&& git checkout stable \
	&& ./configure --enable-shared \
	&& make

echo "Build ffmpeg"
# was originally 3.3.4
cd ~/installs/ffmpeg \
	&& git checkout tags/n3.4.5 \
	&& ./configure --enable-gpl --enable-libx264 --enable-avresample --enable-shared \
	&& make

echo "Build zimg"
# 1/5/2019: was release-2.6.3
cd ~/installs/zimg \
	&& git checkout tags/release-2.8 \
	&& ./autogen.sh \
	&& ./configure \
	&& make

echo "Build Vapoursynth"
cd ~/installs/vapoursynth \
	&& git checkout tags/R45.1 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& mkdir -p ~/.config/vapoursynth \
	&& echo 'export PYTHONPATH=/usr/local/lib/python3.5/site-packages/' | tee --append ~/.bashrc \
	&& echo 'UserPluginDir=/usr/local/lib' | tee --append ~/.config/vapoursynth/vapoursynth.conf

echo "Build Vapoursynth-Editor"
cd ~/installs/vapoursynth-editor \
	&& git checkout tags/r18 \
	&& cd pro \
	&& qmake -norecursive pro.pro CONFIG+=release \
	&& make \
	&& mkdir ~/Applications \
	&& mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor

echo "Build vapoursynth-extra-plugins"
cd ~/installs/vapoursynth-plugins \
	&& ./autogen.sh \
	&& ./configure \
	&& make \

echo "Build MVMulti"
# MVMulti - r7 is the last tag to not require c++ 17.
# This won't be available in gcc until Ubuntu 17.10.
cd ~/installs/vapoursynth-mvtools-sf \
	&& git checkout tags/r7 \
	&& chmod +x autogen.sh \
	&& ./autogen.sh \
	&& ./configure \
	&& make

echo "clone mxDnCnn"

