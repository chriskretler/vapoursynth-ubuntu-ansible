#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export current_tag=v1.2

# may require building ffmpeg and libavcodec from source
# https://github.com/dwbuiten/d2vsource/issues/37

# Does the source code directory exist?
if [ -d ~/installs/d2vsource ]; then
   echo "switching to existing D2VWitch directory."
   cd ~/installs/d2vsource
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $current_tag; then
      echo "Already have the current source code."
   else
      echo "updating source code..."
      git pull origin $version
   fi

else
   echo "Directory does not exist. Cloning repo."
   mkdir -p ~/installs/   
   cd ~/installs/
   git clone https://github.com/dwbuiten/d2vsource
fi

echo "Installing d2vsource"
cd ~/installs/d2vsource \
   && git checkout $current_tag \
   && ./autogen.sh \
	&& ./configure \
	&& make \
	&& sudo make install
