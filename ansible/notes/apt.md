# Playbooks / APT  
  
Ajouter une clef à partir d'une adresse:  
  
    - name: "Add docker repository key"
      apt_key:
        url: "https://download.docker.com/linux/ubuntu/gpg"
        
      
Ajouter un repository et sa clef:

    apt_key:
        keyserver: "hkp://keyserver.ubuntu.com:80"
        id: "E56151BF"
    
    apt_repository:
        repo: "{{ item }}"
        state: present
      with_items:
        - deb http://ftp.de.debian.org/debian jessie-backports main
        - deb http://repos.mesosphere.com/debian jessie main
        
Installer une liste de paquets:        
        
    - name: "Install various command line tools"
      apt: name={{item}} state=installed
      with_items:
        - vim
        - byobu
        - curl
        - wget
        - rsync
        - ranger
        - zsh
        - git
        - sed
        - htop