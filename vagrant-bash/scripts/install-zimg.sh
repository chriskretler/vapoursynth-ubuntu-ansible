#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=release-2.9.2

echo "Updating Ubuntu and Python libraries..."
sudo apt-get update \
   && sudo apt-get install -y autoconf automake libtool pkg-config build-essential python3-dev python-pip git

# Does the source code directory exist?
if [ -d ~/installs/zimg ]; then
   echo "switching to existing zimg directory."
   cd ~/installs/zimg

   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $version; then
      echo "Already have the current zimg source code."
   else
      echo "Updating local zimg source code..."
      git pull origin $version
   fi

else
   echo "zimg directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/sekrit-twc/zimg.git
fi

# Is zimg already installed? Can make tell us what is installed?
echo "Installing zimg"
cd ~/installs/zimg \
   && git checkout $version \
	&& ./autogen.sh \
	&& ./configure \
   && make clean \
   && make \
	&& sudo make install
