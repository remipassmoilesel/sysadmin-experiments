# Pré-requis

Faire pointer un sous domaine vers le VPS. Exemple:

    gitlab.remi-pace.fr

Faire écouter SSH sur 10235:
    
    $ vim /etc/ssh/sshd_config
    
    Port 10235
    
## Déploiement

    $ ./deploy 
    $ ./deploy --tags gitlab
    