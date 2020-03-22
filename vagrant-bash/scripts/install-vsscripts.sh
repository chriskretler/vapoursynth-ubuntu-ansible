#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export havsfunc_tag=r32
export mvsfunc_tag=r8
export adjust_tag=v1

### havsfunc ############
# Does the havsfunc source code directory exist?
if [ -d ~/installs/havsfunc ]; then
   echo "switching to existing havsfunc directory."
   cd ~/installs/havsfunc

   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $havsfunc_tag; then
      echo "Already have the current havsfunc source code."
   else
      echo "source code is stale. Deleting so we can re-clone."
      cd ~/installs
      rm -rf havsfunc
      git clone --branch $havsfunc_tag --depth 1 https://github.com/HomeOfVapourSynthEvolution/havsfunc
   fi

else
   echo "havsfunc directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone --branch $havsfunc_tag --depth 1 https://github.com/HomeOfVapourSynthEvolution/havsfunc
fi

cd ~/installs/havsfunc \
   && git checkout $havsfunc_tag \
   && sudo mkdir -p /usr/share/vsscripts \
   && sudo cp havsfunc.py /usr/share/vsscripts/


### mvsfunc ##############
# Does the mvsfunc source code directory exist?
if [ -d ~/installs/mvsfunc ]; then
   echo "switching to existing mvsfunc directory."
   cd ~/installs/mvsfunc

   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $mvsfunc_tag; then
      echo "Already have the current mvsfunc source code."
   else
      echo "source code is stale. Deleting so we can re-clone."
      cd ~/installs
      rm -rf mvsfunc
      git clone --branch $mvsfunc_tag --depth 1 https://github.com/HomeOfVapourSynthEvolution/mvsfunc
   fi

else
   echo "mvsfunc directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone --branch $mvsfunc_tag --depth 1 https://github.com/HomeOfVapourSynthEvolution/mvsfunc
fi

cd ~/installs/mvsfunc \
   && git checkout $mvsfunc_tag \
   && sudo mkdir -p /usr/share/vsscripts \
   && sudo cp mvsfunc.py /usr/share/vsscripts/


### adjust ##############
# Does the adjust source code directory exist?
if [ -d ~/installs/vapoursynth-adjust ]; then
   echo "switching to existing adjust directory."
   cd ~/installs/vapoursynth-adjust

   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $adjust_tag; then
      echo "Already have the current adjust source code."
   else
      echo "source code is stale. Deleting so we can re-clone."
      cd ~/installs
      rm -rf vapoursynth-adjust
      git clone --branch $adjust_tag --depth 1 https://github.com/dubhater/vapoursynth-adjust
   fi

else
   echo "adjust directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone --branch $adjust_tag --depth 1 https://github.com/dubhater/vapoursynth-adjust
fi

cd ~/installs/vapoursynth-adjust \
   && git checkout $adjust_tag \
   && sudo mkdir -p /usr/share/vsscripts \
   && sudo cp adjust.py /usr/share/vsscripts/
