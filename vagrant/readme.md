#### Vagrant
To install vagrant on ubuntu:<br>
```
sudo apt install vagrant
```

Specific instructions for building an ubuntu desktop vm using packer and adding it to vagrant can be found [here](https://github.com/chriskretler/vsynth-env-provisioning/tree/master/packer/readme.md).

##### Running the vagrant scripts:
All vagrant directories are defined in a `vagrantfile` within the /vagrant-ansible sub-directory. Run the following command to execute those directives:
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

##### Running ansible scripts directly against a running vagrant box:
```
$ export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o IdentityFile=.vagrant/machines/default/virtualbox/private_key -o ControlMaster=auto -o ControlPersist=60s'
$ ansible-playbook --connection=ssh --extra-vars=ansible_user\=\'vagrant\' -i ansible/hosts_vagrant ansible/install_plugins.yml
```

### Troubleshooting:
- ioctl error:<br>
https://superuser.com/questions/1160025/how-to-solve-ttyname-failed-inappropriate-ioctl-for-device-in-vagrant/1277604#1277604
