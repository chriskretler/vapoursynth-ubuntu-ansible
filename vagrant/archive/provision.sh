#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

# Create the chris user
#useradd -m -s /bin/bash -U chris

# cython needed for vsynth
su -c "pip install --upgrade cython" vagrant

# run the install-apps script as a user.
#su -c "source /vagrant/install-apps.sh" vagrant
