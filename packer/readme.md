# packer comes as a pre-built binary:
https://www.packer.io/downloads.html
After extracting:
sudo mv /storage/builds/packer /usr/local/bin

# To build a vagrant box:
Download the ubuntu image from http://releases.ubuntu.com/
to /storage/builds/linux

$ git clone https://github.com/boxcutter/ubuntu
$ cd ubuntu

$ packer build -only=virtualbox-iso -var-file=../vsynth-env-provisioning/packer/ubuntu1604-desktop.json ubuntu.json

packer build -only=virtualbox-iso -var='iso_path=/storage/builds/linux' -var='iso_name=ubuntu-16.04.6-server-amd64.iso' -var='iso_checksum=ac8a79a86a905ebdc3ef3f5dd16b7360' -var='iso_checksum_type=md5' -var-file=ubuntu1604-desktop.json ubuntu.json


# boxcutter json template for 16.04:
https://github.com/boxcutter/ubuntu/blob/master/ubuntu1604-desktop.json

and

https://github.com/boxcutter/ubuntu/blob/master/ubuntu.json#L152

# 1/28/2020: works on mac os from default box-cutter repo:
$ packer -version
1.5.1

$ packer build -var-file=ubuntu1804-desktop.json ubuntu.json
...
--> virtualbox-iso: 'virtualbox' provider box: box/virtualbox/ubuntu1804-desktop-0.1.0.box
