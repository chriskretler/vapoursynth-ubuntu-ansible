#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=r19

install_vsedit() {

   echo "Updating build, python and qt libraries..."
   sudo apt-get update \
      && sudo apt-get install -y autoconf automake libtool pkg-config build-essential python3-dev python-pip qt5-default libqt5websockets5-dev git

   # Does the source code directory exist?
   if [ -d ~/installs/vapoursynth-editor ]; then
      echo "switching to existing vsedit directory."
      cd ~/installs/vapoursynth-editor

      # do we have the current source code?
      tags=`git tag -l`
      if echo "$tags" | grep -q $version; then
         echo "Already have the current vsedit source code."
      else
         echo "updating vapoursynth source code..."
         git pull origin $version
      fi

   else
      echo "vsedit directory does not exist. Cloning repo."
      mkdir -p ~/installs/
      cd ~/installs/
      git clone --branch $version --depth 1 https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
   fi

   # don't need to do make clean. qmake does that for us!
   cd ~/installs/vapoursynth-editor \
      && git checkout $version \
      && cd pro \
      && qmake -norecursive pro.pro CONFIG+=release \
   	&& make \
	   && mkdir -p ~/Applications \
	   && mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor \
	   && sudo ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit \
	   && mkdir -p ~/.local/share/applications \
      && cp /vagrant/vsedit.desktop ~/.local/share/applications
}

# Cannot determine whether current version is installed via ssh,
# as launching vsedit attempts to launch an X window.
vsedit_path=`which vsedit`
if echo "$vsedit_path" | grep -q "vsedit"; then
   echo "vsedit is already installed. Determining version."
   vsedit_version=`vsedit --version`
   if echo "$vsedit_version" | grep -q "$version"; then
      echo "Current version of vsedit is already installed."
      exit
   else
      echo "vsedit is out of date, updating..."
      sudo rm -f /usr/bin/vsedit
      rm -rf ~/Applications/VapourSynth-Editor
      rm -f ~/.local/share/applications/vsedit.desktop
      install_vsedit
   fi
else
   echo "vsedit is not installed, Installing..."
   install_vsedit
fi
