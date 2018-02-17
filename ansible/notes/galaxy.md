# ANsible Galaxy 

... est un système de partage de rôles.
Le serveur est open source et peut être installé localement.

## Installation à partir d'un fichier

Exemple de fichier:

    # from galaxy
    - src: yatesr.timezone
    
    # from GitHub
    - src: https://github.com/bennojoy/nginx
    
    # from GitHub, overriding the name and specifying a specific tag
    - src: https://github.com/bennojoy/nginx
      version: master
      name: nginx_role
    
    # from a webserver, where the role is packaged in a tar.gz
    - src: https://some.webserver.example.com/files/master.tar.gz
      name: http-role
    
    # from GitLab or other git-based scm
    - src: git@gitlab.company.com:mygroup/ansible-base.git
      scm: git
      version: "0.1"  # quoted, so YAML doesn't parse this as a floating-point value
      
Installation:

    $ ansible-galaxy install -r requirements.yml

Afficher des infos sur un rôle:

    $ ansible-galaxy info username.role_name
    
Lister les rôles installés:

    $ ansible-galaxy list    