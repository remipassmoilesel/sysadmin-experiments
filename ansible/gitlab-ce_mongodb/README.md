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
    

## Erreurs courantes

### Clone de sous module par ssh impossible

    Cloning into '/builds/selenee/selenee-dev/infrastructure/common/secrets'...
    fatal: cannot run ssh: No such file or directory
    fatal: unable to fork
    fatal: clone of 'ssh://git@192.168.20.133/selenee/secrets.git' into submodule path '/builds/selenee/selenee-dev/infrastructure/common/secrets' failed
    Failed to clone 'infrastructure/common/secrets'. Retry scheduled
    
Debug possible en utilisant cette configuration de gitlab runner (config.toml):
        
        
    [[runners]]
      pre_clone_script = "echo $PATH; ls -la /usr/bin; env"
      
Une image appelée gitlab runner helper est utilisée pour cloner, et elle ne dipose pas de ssh par défaut.

Il est possible d'utiliser une image custom avec l'option:

    [[runners]]
      [runners.docker]
        helper_image = "ach-docker-hub:5000/selenee/selenee/gitlab-ci-helper:0.1"
    
      