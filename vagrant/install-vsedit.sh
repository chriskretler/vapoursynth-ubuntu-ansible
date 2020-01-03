#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export version=r19

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
   cd ~/installs/
   git clone https://bitbucket.org/mystery_keeper/vapoursynth-editor.git
fi

vsedit_version = `vsedit --version`
if echo "$vsedit_version" | grep -q $version; then
   echo "Current version of vsedit is already installed."
else
   echo "Install vsedit"
   cd ~/installs/vapoursynth-editor/pro \
	   && qmake -norecursive pro.pro CONFIG+=release \
	   && make \
	   && mkdir ~/Applications \
	   && mv ../build/release-64bit-gcc ~/Applications/VapourSynth-Editor \
	   && sudo ln -s ~/Applications/VapourSynth-Editor/vsedit /usr/bin/vsedit
fi

