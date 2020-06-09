### Overview
The goal of the software in this repository is to repeatably deploy vapoursynth on Ubuntu. It leverages packer and vagrant to build test environments, and both bash and ansible to deploy.

The bash and ansible scripts are designed to run within vagrant, but--once verified--can be run on a host desktop.

Specific instructions for building an ubuntu desktop vm using packer and adding it to vagrant can be found [here](https://github.com/chriskretler/vsynth-env-provisioning/tree/master/packer/readme.md).

#### Vagrant
To install vagrant on ubuntu:<br>
```
sudo apt install vagrant
```

#### Ansible
To install ansible on ubuntu:<br>
```
sudo apt install ansible
```

##### Running the vagrant scripts:
All vagrant directories are defined in a `vagrantfile` within the /vagrant-bash and /vagrant-ansible sub-directories. Run the following command to execute those directives:
```
$ vagrant up
```

To run the bash or ansible scripts with a new environment:
```
$ vagrant destroy
$ vagrant up
```
To re-run the bash scripts with an existing vm that is off:
```
vagrant reload --provision-with shell
```
To re-run the ansible scripts with an existing vm that is currently running:
```
vagrant provision --provision-with ansible
```
To shut-down a vagrant machine:
```
vagrant halt
```

### Troubleshooting:
- ioctl error:<br>
https://superuser.com/questions/1160025/how-to-solve-ttyname-failed-inappropriate-ioctl-for-device-in-vagrant/1277604#1277604

- Problems with vapoursynth compilation? Look for libraries and paths in this thread:
https://forum.doom9.org/showthread.php?t=175522

- "Failed to initialize Vapoursynth environment". Your environment can't read vapoursynth.so. Do one of the following:
  - Set the PYTHONPATH variable to the location of vapoursynth.so
  - Create a link to vapoursynth.so in python's standard path, like /usr/local/lib/python3.6/dist-packages/
