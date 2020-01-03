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
git clone https://github.com/sekrit-twc/zimg.git --branch release-2.9.2 --single-branch
git clone https://github.com/vapoursynth/vapoursynth.git --branch R48 --single-branch
git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git --branch r19 --single-branch

echo "Install zimg"
cd ~/installs/zimg \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install

echo "Install Vapoursynth"
cd ~/installs/vapoursynth \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install \
	&& echo 'export PYTHONPATH=/usr/local/lib/python3.5/site-packages/' | tee --append ~/.bashrc \	
	&& sudo ldconfig

echo "Install Vapoursynth-Editor"
cd ~/installs/vapoursynth-editor/pro \
	&& qmake -norecursive pro.pro CONFIG+=release \
	&& make \
	&& mkdir ~/Applications \
	&& mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor \
	&& sudo ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

