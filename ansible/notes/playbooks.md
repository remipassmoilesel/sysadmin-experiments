# Playbooks Ansible

## Lancer un playbook

Commande:

    $ ansible-playbook playbook-name.yaml
    
Spécifier un fichier d'inventaire:
    
    $ ansible-playbook -i inventory.cfg playbook-name.yaml

## Exemple rapide 

Pour vérifier la syntaxe, utiliser `yamllint`, les indentations de deux ou quatres sont possibles.

    - hosts: slaves
      vars:
        masterAddress: "192.168.1.149"
        masterHostName: "mesos1-master1.mesos"
        slaveAddress: "192.168.1.139"
    
      tasks:
      - name: "Add Mesos repository key"
        apt_key:
          keyserver: "hkp://keyserver.ubuntu.com:80"
          id: "E56151BF"
    
      - name: "Add Mesos repository"
        apt_repository:
          repo: "{{ item }}"
          state: present
        with_items:
          - deb http://ftp.de.debian.org/debian jessie-backports main
          - deb http://repos.mesosphere.com/debian jessie main

## Variables
    
    vars:
        masterAddress: "192.168.1.149"
        masterHostName: "mesos1-master1.mesos"
        slaveAddress: "192.168.1.139"

Passer des variables en ligne de commande:

    $ ansible-playbook release.yml --extra-vars "version=1.23.45 other_variable=foo"


## Commandes arbitraires

    - name: "Change shell for root"
      raw: chsh -s /bin/zsh

## PIP

    - name: "Install docker compose and a functionnal mesos cli"
      pip:
        name: "{{ item }}"
        state: latest
      with_items:
        - docker-compose
        - mesos.cli
        
## SystemD
  
    - name: "Enable master mode"
      systemd:
        name: mesos-slave
        enabled: "yes"
        state: started
  
    - name: "Disable master mode"
      systemd:
        name: mesos-master
        enabled: "no"
        state: stopped

## Bower

Installer des packages à partir d'un bower.json:
          
    - name: "Update application dependencies"
      bower:
        path: "/opt/safran-des-lices/src/main/resources/static"
        
/!\ Attention, ne doit pas contenir de conflits non résolus        