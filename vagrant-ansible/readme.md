#### To-Dos:
1. Finish the rest of the package installs
2. Test the ansible run on a host machine
2. Only set the env var file once for all roles in a playbook.

#### Using ansible directly on vagrant box:
$ export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o IdentityFile=/storage/code/vsynth-env-provisioning/vagrant-ansible/.vagrant/machines/default/virtualbox/private_key -o ControlMaster=auto -o ControlPersist=60s'

$ ansible-playbook --connection=ssh --extra-vars=ansible_user\=\'vagrant\' -i hosts playbook.yml


#### SSH key validation:
For VMs, ssh key validation isn't necessary as they're ephemeral, as such we've included the following line in an ansible.cfg file:

[defaults]
host_key_checking = False

This should not be used for persistent hosts.
