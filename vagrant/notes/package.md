# Package de machine virtuelle

Source: https://www.dev-metal.com/copy-duplicate-vagrant-box/

Créer une machine:

    $ vagrant up
    $ vagrant halt
    
Package:

    $ vagrant package    
    
Réutiliser la machine:

    $ mkdir /tmp/new-machine && cd /tmp/new-machine
    $ vagrant init   
    $ vim Vagrantfile
    
    config.vm.box = "ubuntu-prepared-box"
    config.vm.box_url = "file://path/to/box/location.box"
    
    $ vagrant up