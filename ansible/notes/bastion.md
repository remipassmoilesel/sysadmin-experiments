# Utiliser Ansible à travers un bastion

Créer une configuration SSH avec rebond:

    $ cd ansible-project
    $ mkdir configurations
    $ vim bastion-config.cfg

    Host ssh.bastion
        IdentityFile ~/.ssh/id_rsa
        HostName 10.0.0.200
        Port 22
        User ubuntu
    
    Host 172.*
      ProxyCommand ssh -W %h:%p ssh.bastion
      IdentityFile ~/.ssh/id_rsa
      
Utiliser cette configuration dans l'inventaire:

    $ vim inventory.cfg
    
    [all]
    ansible_ssh_common_args = "-o ControlMaster=auto -o ControlPersist=30m -F ./configurations/bastion-config.cfg"          

