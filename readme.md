The vagrant boxes provided by the ubuntu community don't provide a UI.
To build one with a UI, you'll need to use packer to build one based on 
the box cutter json templates (https://github.com/boxcutter/ubuntu),
or create one of your own.

#To install vagrant:
sudo apt install vagrant

# To create:
vagrant up

# To test changes from beginning:
vagrant destroy
vagrant up

# To test for idempotency
vagrant reload --provision-with shell

# To shut-down a vagrant machine
vagrant halt
