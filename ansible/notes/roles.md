# Roles

Permettent de réutiliser des playbooks.

Créer un role avec cette structure:
    
    project/
    ├── playbook.yaml
    └── roles
        │   
        └── role-name
            ├── files
            │   └── various files...    
            ├── tasks
            │   └── main.yaml // nom fixe 
            └── templates
                └── various templates...

Ou utiliser ansible-galaxy pour créer la structure:

    $ ansible-galaxy init role_name
                
Puis l'appeler dans un playbook, dans la liste de tâches:

      tasks:
      - name: "Install various helpers"
        include_role: name=install-helpers
    
      - name: "Install docker"
        include_role: name=install-docker
        
Ou de cette manière:        
              
      ---
      - hosts: ubuntuPlayground
        vars:
          nats_base_path: "/opt"
          nats_config_basepath: "/etc/nats"
      
        roles:
          - install-nats
              
Utiliser des variables:

    tasks:
    - include_role:
        name: install-nats
        args:
          nats_base_path: vars.nats_base_path
          nats_config_basepath: vars.nats_config_basepath
          nats_port: vars.nats_port
              
                      
Utiliser role_path pour connaitre le chemin d'un fichier:

    - name: "Populate zshrc"
      copy:
        src: "{{ role_path }}/files/dot-zshrc"
        dest: "/root/.zshrc"
            