#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export current_tag=v3
export version="D2V Witch version: 3"

install_d2vwitch() {

   echo "Updating ubuntu, build, python and qt libraries..."
   apt-get update \
      && apt-get install -y git autoconf automake libtool pkg-config build-essential libavformat-dev libavcodec-dev qt5-default

   # Does the source code directory exist?
   if [ -d ~/installs/D2VWitch ]; then
      echo "switching to existing D2VWitch directory."
      cd ~/installs/D2VWitch

      # do we have the current source code?
      tags=`git tag -l`
      if echo "$tags" | grep -q $current_tag; then
         echo "Already have the current D2VWitch source code."
      else
         echo "source code is stale. Deleting so we can re-clone."
         cd ~/installs
         rm -rf D2VWitch
         git clone --branch $current_tag --depth 1 https://github.com/dubhater/D2VWitch.git
      fi

   else
      echo "D2VWitch directory does not exist. Cloning repo."
      mkdir -p ~/installs/
      cd ~/installs/
      git clone --branch $current_tag --depth 1 https://github.com/dubhater/D2VWitch.git
   fi

   cd ~/installs/D2VWitch \
      && git checkout $current_tag \
      && ./autogen.sh \
      && ./configure \
      && make clean \
      && make \
      && sudo make install
}

d2vwitch_path=`which d2vwitch`
if echo "$d2vwitch_path" | grep -q "/bin"; then
   echo "d2vwitch is already installed. Determining version."
   # d2vwitch version cmd outputs to stderr!!!
   # https://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
   d2v_version=`d2vwitch --version 2>&1 | sed -n 1p`
   if echo "$d2v_version" | grep -q "$version"; then
      echo "Current version of d2vwitch is already installed."
      exit
   else
      echo "d2vwitch is out of date, installing latest version..."
      install_d2vwitch
   fi
else
   echo "d2vwitch is not installed, Installing..."
   install_d2vwitch
fi
