#### Running playbooks locally.
Run from /ansible directory<br>
`$ ansible-playbook -i hosts_local install_all.yml --ask-become-pass`<br>
or:<br>
`$ ansible-playbook -i hosts_local install_vapoursynth.yml --ask-become-pass`<br>
or:<br>
`$ ansible-playbook -i hosts_local install_plugins.yml --ask-become-pass`

#### Running playbook against running vagrant box.
Run from the /bionic or /focal directory.<br>
Note: the box must have been previosuly provisioned to use this command:
```
$ export ANSIBLE_SSH_ARGS='-o UserKnownHostsFile=/dev/null -o IdentitiesOnly=yes -o IdentityFile=.vagrant/machines/default/virtualbox/private_key -o ControlMaster=auto -o ControlPersist=60s'
$ ansible-playbook --connection=ssh --extra-vars=ansible_user\=\'vagrant\' -i ansible/hosts_vagrant ansible/install_plugins.yml
```

#### FAQ
1. Where are vapoursynth and the supporting scripts installed?
  - They have been put here: /usr/local/lib/{your_python_3_version}/site-packages
  - Based on this: https://wiki.debian.org/Python#Deviations_from_upstream

2. SSH key validation:
For vagrant VMs, ssh key validation isn't necessary as they're ephemeral, as such we've included the following line in an ansible.cfg file:
```
[defaults]
host_key_checking = False
```
This should not be used for persistent hosts.

#### To-Dos:
1. Only set the env var file once for all roles in a playbook.
2. Common spot for vars, in group_vars directory.
  - https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html
3. One readme
4. more instructive messages when ansible checks (like ld.so.conf) fail.
5. ubuntu 20.04
  - plugins needing meson >45:
  - dfttest
  - bm3d
  - mvtools
  - could install meson 48 in ubuntu 18.04 via pip.
6. mvtools_tag: v23
