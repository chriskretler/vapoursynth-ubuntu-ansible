#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export damb_version=v3
export fmtc_version=r22
export mvtools_version=v21
export fft_version=master
export nnedi3_version=v12

### vapoursynth-damb: audio support ###
if [ -d ~/installs/vapoursynth-damb ]; then
   echo "switching to existing directory."
   cd ~/installs/vapoursynth-damb
else
   echo "damb directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/dubhater/vapoursynth-damb
fi

sudo apt-get update \
   && sudo apt-get install -y libsndfile1 libsndfile1-dev

cd ~/installs/vapoursynth-damb \
   && git checkout $damb_version \
   && ./autogen.sh \
   && ./configure \
   && make clean \
   && make \
   && sudo make install

   
### fmtc ###
if [ -d ~/installs/fmtconv ]; then
   echo "switching to existing directory."
   cd ~/installs/fmtconv
else
   echo "fmtconv directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/EleonoreMizo/fmtconv
fi

cd ~/installs/fmtconv \
   && git checkout $ftmc_version \
   && cd build/unix/ \
   && ./autogen.sh \
   && ./configure \
   && make clean \
   && make \
   && sudo make install

   
### mvtools ###
if [ -d ~/installs/vapoursynth-mvtools ]; then
   echo "switching to existing directory."
   cd ~/installs/vapoursynth-mvtools
else
   echo "mvtools directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   https://github.com/dubhater/vapoursynth-mvtools
fi

sudo apt-get update \
   && sudo apt-get install -y libfftw3-3 libfftw3-dev

cd ~/installs/vapoursynth-mvtools \
   && git checkout $mvtools_version \
   && ./autogen.sh \
   && ./configure \
   && make clean \
   && make \
   && sudo make install


### fft3dfilter ###
if [ -d ~/installs/VapourSynth-FFT3DFilter ]; then
   echo "switching to existing directory."
   cd ~/installs/VapourSynth-FFT3DFilter
else
   echo "fft3dfilter directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/myrsloik/VapourSynth-FFT3DFilter
fi

sudo apt-get update \
   && sudo apt-get install -y meson ninja-build libfftw3-3 libfftw3-dev

cd ~/installs/VapourSynth-FFT3DFilter \
   && git checkout $fft_version \
   && meson build \
   && ninja -C build \
   && sudo ninja -C build install
   
### nnedi3 ###
if [ -d ~/installs/vapoursynth-nnedi3 ]; then
   echo "switching to existing directory."
   cd ~/installs/vapoursynth-nnedi3
else
   echo "nnedi3 directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/dubhater/vapoursynth-nnedi3
fi

cd ~/installs/vapoursynth-nnedi3 \
   && git checkout $nnedi3_version \
   && ./autogen.sh \
   && ./configure \
   && make clean \
   && make \
   && sudo make install

