### Packer
Packer comes as a pre-built binary:<br>
https://www.packer.io/downloads.html<br>
After extracting:
```
$ sudo mv /storage/builds/packer /usr/local/bin
$ packer -version
1.5.1
```

#### Building the ubuntu desktop for later use by vagrant:
Note: box-cutter's vagrant box does not support vbox 6.x as of 1/30/2020.
```
$ git clone https://github.com/boxcutter/ubuntu
$ cd ubuntu
$ packer build -var-file=ubuntu1804-desktop.json ubuntu.json
...
--> virtualbox-iso: 'virtualbox' provider box: box/virtualbox/ubuntu1804-desktop-0.1.0.box

`$ sudo find / -type f -iname *.box`
/storage/code/ubuntu/box/virtualbox/ubuntu1804-desktop-0.1.0.box
```

##### Add packer image to vagrant:
```
$ vagrant box add /storage/code/ubuntu/box/virtualbox/ubuntu1804-desktop-0.1.0.box --name=ubuntu1804-desktop
==> box: Box file was not detected as metadata. Adding it directly...
==> box: Adding box 'ubuntu1804-desktop' (v0) for provider:
    box: Unpacking necessary files from: file:///storage/code/ubuntu/box/virtualbox/ubuntu1804-desktop-0.1.0.box
==> box: Successfully added box 'ubuntu1804-desktop' (v0) for 'virtualbox'!

$ vagrant box list
ubuntu1804-desktop (virtualbox, 0)
```
