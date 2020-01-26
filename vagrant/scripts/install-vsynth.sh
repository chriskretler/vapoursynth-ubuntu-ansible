#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=R48

# Does the source code directory exist?
if [ -d ~/installs/vapoursynth ]; then
   echo "switching to existing vapoursynth directory."
   cd ~/installs/vapoursynth
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $version; then
      echo "Already have the current vapoursynth source code."
   else
      echo "updating vapoursynth source code..."
      git pull origin $version
   fi

else
   echo "vapoursynth directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/vapoursynth/vapoursynth.git
fi

# need to do this in bash, for some reason it works fine from the cmd line
vsversion=`PYTHONPATH=/usr/local/lib/python3.6/site-packages vspipe --version`
if echo "$vsversion" | grep -q $version; then
   echo "Current version of vsynth is already installed."
else
   echo "Installing vsynth"
   cd ~/installs/vapoursynth \
      && git checkout $version \
	   && ./autogen.sh \
	   && ./configure \
	   && make \
	   && sudo make install \
      && mkdir -p ~/.config/vapoursynth \
	   && echo 'export PYTHONPATH=/usr/local/lib/python3.6/site-packages/' | tee --append ~/.bashrc \
      && echo 'UserPluginDir=/usr/local/lib' | tee --append ~/.config/vapoursynth/vapoursynth.conf \
	   && echo 'include /usr/local/lib' | sudo tee --append /etc/ld.so.conf \
	   && sudo ldconfig
fi
