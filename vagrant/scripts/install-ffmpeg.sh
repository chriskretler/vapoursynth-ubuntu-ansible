#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export current_tag=n4.2.2
export version=4.2.2

# ldconfig fixes inability to find libavdevice from /usr/local/lib
# path must be part of /etc/ld.so.conf
install_vsedit() {
   cd ~/installs/ffmpeg \
      && git checkout $current_tag \
      && ./configure --enable-gpl --enable-libx264 --enable-shared \
      && make \
      && sudo make install \
      && sudo ldconfig
}

sudo apt-get update \
   && sudo apt-get install -y nasm yasm libx264-dev libx264-152

# Does the source code directory exist?
if [ -d ~/installs/ffmpeg ]; then
   echo "switching to existing directory."
   cd ~/installs/ffmpeg

   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $current_tag; then
      echo "Already have the current source code."
   else
      echo "Updating local source code..."
      git pull origin $current_tag
   fi

else
   echo "ffmpeg directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/ffmpeg/ffmpeg.git
fi

ffmpeg_path=`which ffmpeg`
if echo "$ffmpeg_path" | grep -q "/bin"; then
   echo "ffmpeg is already installed. Determining version."
   ffmpeg_version=`ffmpeg -version` | sed -n 1p
   if echo "$ffmpeg_version" | grep -q "$version"; then
      echo "Current version of ffmpeg is already installed."
      exit
   else
      echo "ffmpeg is out of date, updating..."
      install_ffmpeg
   fi
else
   echo "ffmpeg is not installed, Installing..."
   install_ffmpeg 
fi
