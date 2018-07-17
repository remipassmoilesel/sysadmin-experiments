# Pré-requis

Faire pointer un sous domaine vers le VPS. Exemple:

    gitlab.remi-pace.fr

Faire écouter SSH sur 10235:
    
    $ vim /etc/ssh/sshd_config
    
    Port 10235
    
## Déploiement

    $ ./deploy 
    $ ./deploy --tags gitlab
    
## Gitlab runner

Pour déployer le gitlab runner, copier le token d'enregistrement:

    Admin area > Overview > Runners > Registration token
    
Puis sur le serveur distant:

    $ docker exec -it dcomposegitlab_gitlab-runner_1 gitlab-runner register
    
