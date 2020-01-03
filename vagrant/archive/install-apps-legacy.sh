#!/bin/bash -x

# 4/19/2018: include nnedi3cl when I figure out what version of boost is required.
# https://forum.doom9.org/showthread.php?p=1839813#post1839813
# https://github.com/HomeOfVapourSynthEvolution/VapourSynth-NNEDI3CL

# 4/19/2018: include myrosilk's fft3d update when ubuntu 18.04 is out, which will
# provide an updated gcc version
# https://github.com/myrsloik/VapourSynth-FFT3DFilter

# 12/27/2019: Per this:
# http://vapoursynth.com/doc/installation.html#linux-and-os-x-compilation-instructions
# the following are not needed:
# nasm
# l-smash
# x264
# ffmpeg (still needed for extra plugins)
# zimg (image magick) is optional.

echo "Downloading source code..."
mkdir ~/installs
cd ~/installs
git clone https://github.com/l-smash/l-smash.git
git clone https://code.videolan.org/videolan/x264.git
git clone https://github.com/ffmpeg/ffmpeg.git
git clone https://github.com/sekrit-twc/zimg.git
git clone https://github.com/vapoursynth/vapoursynth.git
git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
git clone https://github.com/darealshinji/vapoursynth-plugins
git clone https://github.com/IFeelBloated/vapoursynth-mvtools-sf
#git clone https://github.com/kice/vs_mxDnCNN

echo "Install NASM"
# Required for x264
# 2.13--probably sufficient for x264 and vsynth--comes with ubuntu 18.04.
mkdir ~/installs/nasm \
	&& cd ~/installs/nasm \
	&& wget http://www.nasm.us/pub/nasm/releasebuilds/2.14.02/nasm-2.14.02.tar.xz \
	&& tar -xf nasm-2.14.02.tar.xz --strip-components=1 \
	&& ./configure --prefix=/usr \
	&& make \
	&& sudo make install

echo "Install l-smash"
# 12/27/2019: no new versions since 2.14.5
cd ~/installs/l-smash \
	&& git checkout tags/v2.14.5 \
	&& ./configure --enable-shared \
	&& make lib \
	&& sudo make install-lib

echo "Install x264"
# 1/5/2019: switch to stable branch
cd ~/installs/x264 \
	&& git checkout stable \
	&& ./configure --enable-shared \
	&& make \
	&& sudo make install

echo "Install ffmpeg"
# was originally 3.3.4
cd ~/installs/ffmpeg \
	&& git checkout tags/n3.4.7 \
	&& ./configure --enable-gpl --enable-libx264 --enable-avresample --enable-shared \
	&& make \
	&& sudo make install

echo "Install zimg"
cd ~/installs/zimg \
	&& git checkout tags/release-2.9.2 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install

echo "Install Vapoursynth"
# 12/27/2019: Will that python 3.5 fly?
cd ~/installs/vapoursynth \
	&& git checkout tags/R48 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install \
	&& mkdir -p ~/.config/vapoursynth \
	&& echo 'export PYTHONPATH=/usr/local/lib/python3.5/site-packages/' | tee --append ~/.bashrc \
	&& echo 'UserPluginDir=/usr/local/lib' | tee --append ~/.config/vapoursynth/vapoursynth.conf \
	&& echo 'include /usr/local/lib' | sudo tee --append /etc/ld.so.conf \
	&& sudo ldconfig \

echo "Install Vapoursynth-Editor"
cd ~/installs/vapoursynth-editor \
	&& git checkout tags/r19 \
	&& cd pro \
	&& qmake -norecursive pro.pro CONFIG+=release \
	&& make \
	&& mkdir ~/Applications \
	&& mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor \
	&& sudo ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

echo "Install vapoursynth-extra-plugins"
cd ~/installs/vapoursynth-plugins \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install

echo "Install MVMulti"
# MVMulti - r7 is the last tag to not require c++ 17.
# This won't be available in gcc until Ubuntu 17.10.
cd ~/installs/vapoursynth-mvtools-sf \
	&& git checkout tags/r7 \
	&& chmod +x autogen.sh \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install

#echo "clone mxDnCnn"

