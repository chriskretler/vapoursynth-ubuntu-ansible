#!/bin/bash -x
export DEBIAN_FRONTEND=noninteractive
export havsfunc_tag=r32
export mvsfunc_tag=r8
export adjust_tag=v1

### havsfunc ############
# Does the havsfunc source code directory exist?
if [ -d ~/installs/havsfunc ]; then
   echo "switching to existing vapoursynth directory."
   cd ~/installs/havsfunc
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $havsfunc_tag; then
      echo "Already have the current havsfunc source code."
   else
      echo "updating havsfunc source code..."
      git pull origin $havsfunc_tag
   fi

else
   echo "havsfunc directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/HomeOfVapourSynthEvolution/havsfunc
fi

cd ~/installs/havsfunc \
   && git checkout $havsfunc_tag \
   && sudo cp havsfunc.py /usr/share/vsscripts/


### mvsfunc ##############  
# Does the havsfunc source code directory exist?
if [ -d ~/installs/mvsfunc ]; then
   echo "switching to existing vapoursynth directory."
   cd ~/installs/mvsfunc
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $mvsfunc_tag; then
      echo "Already have the current mvsfunc source code."
   else
      echo "updating mvsfunc source code..."
      git pull origin $mvsfunc_tag
   fi

else
   echo "mvsfunc directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/HomeOfVapourSynthEvolution/mvsfunc
fi

cd ~/installs/mvsfunc \
   && git checkout $mvsfunc_tag \
   && sudo cp mvsfunc.py /usr/share/vsscripts/
   
   
### adjust ##############  
# Does the adjust source code directory exist?
if [ -d ~/installs/vapoursynth-adjust ]; then
   echo "switching to existing vapoursynth directory."
   cd ~/installs/vapoursynth-adjust
   
   # do we have the current source code?
   tags=`git tag -l`
   if echo "$tags" | grep -q $adjust_tag; then
      echo "Already have the current adjust source code."
   else
      echo "updating adjust source code..."
      git pull origin $adjust_tag
   fi

else
   echo "adjust directory does not exist. Cloning repo."
   mkdir -p ~/installs/
   cd ~/installs/
   git clone https://github.com/dubhater/vapoursynth-adjust
fi

cd ~/installs/vapoursynth-adjust \
   && git checkout $adjust_tag \
   && sudo cp adjust.py /usr/share/vsscripts/
