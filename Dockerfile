FROM ubuntu:16.04

RUN apt-get update \
	&& apt-get install -y build-essential git yasm libass-dev python3-pip python3-dev cython3 \
	autoconf libtool libmagick++-dev qt5-default libfftw3-dev wget

ENV HOME /usr/local/vsynth-install
RUN mkdir -p $HOME
WORKDIR $HOME

# Required to fix a compilation error in vapoursynth.
RUN pip3 install cython -U

RUN git clone https://github.com/l-smash/l-smash.git \
	&& git clone git://git.videolan.org/x264.git \
	&& git clone https://github.com/ffmpeg/ffmpeg.git \
	&& git clone https://github.com/sekrit-twc/zimg.git \
	&& git clone https://github.com/vapoursynth/vapoursynth.git \
	&& git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git

RUN mkdir $HOME/nasm \
	&& cd $HOME/nasm \
	&& wget http://www.nasm.us/pub/nasm/releasebuilds/2.13.01/nasm-2.13.01.tar.xz \
	&& tar -xf nasm-2.13.01.tar.xz --strip-components=1 \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install

RUN cd $HOME/l-smash \
	&& ./configure --enable-shared \
    && make lib \
	&& make install-lib

## needed nasm 2.13 here. Ubuntu version is 2.11, thus the disable.
RUN cd $HOME/x264 \
#	&& ./configure --enable-shared --disable-asm \
	&& ./configure --enable-shared \
	&& make \
	&& make install

RUN cd $HOME/ffmpeg \
	&& ./configure --enable-gpl --enable-libx264 --enable-avresample --enable-shared \
	&& make \
	&& make install

RUN cd $HOME/zimg \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

## VapourSynth
RUN cd $HOME/vapoursynth \
	&& git checkout tags/R38 \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install \
	&& mkdir -p $HOME/.config/vapoursynth \
	&& echo 'UserPluginDir=/usr/local/lib' | tee --append $HOME/.config/vapoursynth/vapoursynth.conf \
	&& echo 'include /usr/local/lib' | tee --append /etc/ld.so.conf \
	&& ldconfig

## VapourSynth-Editor
RUN cd $HOME/vapoursynth-editor/pro \
	&& qmake pro.pro \
	&& make \
	&& mkdir $HOME/Applications \
	&& mv ../build/release-64bit-gcc $HOME/Applications/VapourSynth-Editor \
	&& ln -s $HOME/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit

## MVMulti
RUN git clone https://github.com/IFeelBloated/vapoursynth-mvtools-sf \
	&& cd $HOME/vapoursynth-mvtools-sf \
	&& git checkout tags/r7 \
	&& chmod +x autogen.sh \
	&& ./autogen.sh \
	&& ./configure \
	&& make \
	&& make install

CMD /bin/bash
