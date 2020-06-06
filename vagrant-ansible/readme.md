#### To-Dos:
1. breakout plugins and scripts into separate groups of roles and places in the playbook.
2. ansible running locally
3. ubuntu 20.04
  - plugins needing meson >45:
   - dfttest
   - bm3d
   - mvtools
   - could install meson 48 in ubuntu 18.04 via pip.
4. mvtools_tag: v23
5. Only set the env var file once for all roles in a playbook.

#### Using ansible directly on vagrant box:
$ export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o IdentityFile=/storage/code/vsynth-env-provisioning/vagrant-ansible/.vagrant/machines/default/virtualbox/private_key -o ControlMaster=auto -o ControlPersist=60s'

$ ansible-playbook --connection=ssh --extra-vars=ansible_user\=\'vagrant\' -i hosts playbook.yml


#### SSH key validation:
For VMs, ssh key validation isn't necessary as they're ephemeral, as such we've included the following line in an ansible.cfg file:

[defaults]
host_key_checking = False

This should not be used for persistent hosts.
