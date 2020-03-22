#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
# R48 results in qtgmc issues with my AMD phenom 2 1060T processor,
# probably due to processor age.
export version=R47.2

install_vsynth() {

   sudo apt-get update \
      && sudo apt-get install -y autoconf automake libtool pkg-config build-essential python3-dev python3-pip git cython3

   # cython3 needed for vsynth
   pip3 install --upgrade cython --user

   # Does the source code directory exist?
   if [ -d ~/installs/vapoursynth ]; then
      echo "switching to existing vapoursynth directory."
      cd ~/installs/vapoursynth

      # do we have the current source code?
      tags=`git tag -l`
      if echo "$tags" | grep -q $version; then
         echo "Already have the current vapoursynth source code."
      else
         echo "vapoursynth source code is stale. Deleting so we can re-clone."
         cd ~/installs
         rm -rf vapoursynth
         git clone --branch $version --depth 1 https://github.com/vapoursynth/vapoursynth.git
      fi

   else
      echo "Cloning vsynth repo."
      mkdir -p ~/installs/
      cd ~/installs/
      git clone --branch $version --depth 1 https://github.com/vapoursynth/vapoursynth.git
   fi

   echo "Installing vsynth"
   cd ~/installs/vapoursynth \
      && git checkout $version \
      && ./autogen.sh \
      && ./configure \
      && make clean \
      && make \
      && sudo make install \
      && mkdir -p ~/.config/vapoursynth \
      && echo 'export PYTHONPATH=/usr/local/lib/python3.6/site-packages/' | tee --append ~/.bashrc \
      && echo 'UserPluginDir=/usr/local/lib' | tee --append ~/.config/vapoursynth/vapoursynth.conf \
      && echo 'include /usr/local/lib' | sudo tee --append /etc/ld.so.conf \
      && sudo ldconfig
}

vspipe_path=`which vspipe`
if echo "$vspipe_path" | grep -q "vspipe"; then
   echo "vapoursynth is already installed. Determining version."
   # for some reason setting this in the install script is not immediately effective
   vsynth_version=`PYTHONPATH=/usr/local/lib/python3.6/site-packages vspipe --version`
   #vsynth_version=`vspipe --version`
   if echo "$vsynth_version" | grep -q "$version"; then
      echo "Current version of vapoursynth is already installed, moseying on..."
      exit
   else
      echo "vsynth is out of date, updating..."
      install_vsynth
   fi
else
   echo "vsynth is not installed, Installing..."
   install_vsynth
fi
