### Overview
Ansible playbooks for installing vapoursynth, it's dependencies, select plugins and scripts on Ubuntu bionic and focal. Instructions for running against VirtualBox VMs are also included, primarily for test purposes.

#### Ansible
To install ansible on ubuntu:<br>
```
sudo apt install ansible
```

#### Running playbooks locally.
Run from /ansible directory<br>
`$ ansible-playbook -i hosts_local install_all.yml --ask-become-pass`<br>
or:<br>
`$ ansible-playbook -i hosts_local install_vapoursynth.yml --ask-become-pass`<br>
or:<br>
`$ ansible-playbook -i hosts_local install_plugins.yml --ask-become-pass`


#### Using with a VirtualBox VM:
1. create vm:
  - download iso: https://releases.ubuntu.com/focal/ubuntu-20.04-desktop-amd64.iso
  - install
2. allow ssh to guest via port forwarding
  - virtualbox settings -> network -> adapter 1 -> advanced:
    - set adapter type to: paravirtualized Network
    - Under Port Forwarding: create a rule with host ip:port - 127.0.0.1:2222 and guest ip:port = blank:22
3. Add local key to guest, to avoid having to use a password.
  - `scp -P 2222 ~/.ssh/ssh_user_ed25519_key.pub my-virtualbox-user@127.0.0.1:~/.ssh/authorized_keys`
4. Switch to /bionic/ansible or /focal directory.
4. Run playbook:
  - `ansible-playbook -i hosts_virtualbox install_vapoursynth.yml --ask-become-pass`


#### FAQ
1. Where are vapoursynth and the supporting scripts installed?
  - They have been put here: /usr/local/lib/{your_python_3_version}/site-packages
  - Based on this: https://wiki.debian.org/Python#Deviations_from_upstream

2. SSH key validation:
For VirtualBox VMs, ssh key validation isn't necessary as they're ephemeral, as such we've included the following line in an ansible.cfg file:
```
[defaults]
host_key_checking = False
```
This should not be used for persistent hosts.


### Troubleshooting:
- Problems with vapoursynth compilation? Look for libraries and paths in this thread:
https://forum.doom9.org/showthread.php?t=175522

- "Failed to initialize Vapoursynth environment". Your environment can't read vapoursynth.so. Do one of the following:
  - Set the PYTHONPATH variable to the location of vapoursynth.so
  - Create a link to vapoursynth.so in python's standard path, like /usr/local/lib/python3.6/dist-packages/

#### To-Dos:
1. ubuntu 20.04
  - plugins needing meson >45:
  - dfttest
  - bm3d
  - mvtools
  - could install meson 48 in ubuntu 18.04 via pip.
2. One readme
3. more instructive messages when ansible checks (like ld.so.conf) fail.
4. mvtools_tag: v23
