#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=v3

# Does the source code directory exist?
if [ -d ~/installs/D2VWitch ]; then
   echo "switching to existing D2VWitch directory."
   cd ~/installs/D2VWitch
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $version; then
      echo "Already have the current D2VWitch source code."
   else
      echo "updating D2VWitch source code..."
      git pull origin $version
   fi

else
   echo "D2VWitch directory does not exist. Cloning repo."
   cd ~/installs/
   git clone https://github.com/dubhater/D2VWitch.git
fi

# need to do this in bash, for some reason it works fine from the cmd line
d2v_version=`d2vwitch --version`
if echo "$d2v_version" | grep -q $version; then
   echo "Current version of d2vwitch is already installed."
else
   echo "Installing d2vwitch"
   cd ~/installs/D2VWitch \
      && git checkout $version \
	   && ./autogen.sh \
	   && ./configure \
	   && make \
	   && sudo make install
fi
