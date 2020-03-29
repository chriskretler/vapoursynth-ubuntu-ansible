### To-Dos:
1. The main task for every role should check for installed version if it can do so. None of the package updates, git or install steps should occur if the current version is installed. can't do this with zimg.
2. Only set the env var file once for all roles in a playbook.

### Provisioning VMs
If vm has never been provisioned before:
$ vagrant up

If vm is not running:
$ vagrant reload --provision-with ansible

If vm is running:
$ vagrant provision --provision-with ansible

### Using ansible directly:
$ export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o IdentityFile=/storage/code/vsynth-env-provisioning/vagrant-ansible/.vagrant/machines/default/virtualbox/private_key -o ControlMaster=auto -o ControlPersist=60s'

$ ansible-playbook --connection=ssh --extra-vars=ansible_user\=\'vagrant\' -i hosts playbook.yml


### SSH key validation:
For VMs, ssh key validation isn't necessary as they're ephemeral, as such we've included the following line in an ansible.cfg file:

[defaults]
host_key_checking = False

This should not be used for persistent hosts.
