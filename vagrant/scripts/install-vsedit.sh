#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=r19

install_vsedit() {
   cd ~/installs/vapoursynth-editor \
      && git checkout $version \
      && cd pro \
      && qmake -norecursive pro.pro CONFIG+=release \
   	&& make \
	   && mkdir -p ~/Applications \
	   && mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor \
	   && sudo ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit \
	   && mkdir -p ~/.local/share/applications \
      && cp ~/vsedit.desktop ~/.local/share/applications
}


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
   echo "vapoursynth directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
fi

vsedit_path=`which vsedit`
if echo "$vsedit_path" | grep -q "/bin"; then
   echo "vsedit is already installed. Determining version."
   vsedit_version=`vsedit --version`
   if echo "$vsedit_version" | grep -q "$version"; then
      echo "Current version of vsedit is already installed."
      exit
   else
      echo "vsedit is out of date, updating..."
      sudo rm -f /usr/bin/vsedit
      rm -rf ~/Applications
      rm -f ~/.local/share/applications/vsedit.desktop
      install_vsedit
   fi
else
   echo "vsedit is not installed, Installing..."
   install_vsedit 
fi

