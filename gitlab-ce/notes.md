# Gitlab-ce

## Installation 

Voir les playbooks ansible.

## Gitlab runner

Pour déployer le gitlab runner, copier le token d'enregistrement:

    Admin area > Overview > Runners > Registration token
    
Puis sur le serveur distant:

    $ docker exec -it dcomposegitlab_gitlab-runner_1 gitlab-runner register


## Utiliser des sous modules

Utiliser des urls de sous modules relatifs:

    [submodule "sub/module1"]
    	path = sub/module1
    	url = ../module1.git
    [submodule "sub/module2"]
    	path = sub/module2
    	url = ../../group2/module1.git    
    

## Erreurs courantes

## Mode debug pour le pipeline

    image: "..."
    variables:
      CI_DEBUG_TRACE: "true"


### Clone de sous module par ssh impossible

Généralement, mieux vaut utiliser le clone http qui permet d'utiliser les même drotis qu'un utilisateur standard.

    Cloning into '/builds/...'...
    fatal: cannot run ssh: No such file or directory
    fatal: unable to fork
    fatal: clone of 'ssh://git@XX.XX.XX.XX/../..git' into submodule path '/builds/.../..-dev/sub/module1' failed
    Failed to clone 'sub/module1'. Retry scheduled
    
Debug possible en utilisant cette configuration de gitlab runner (config.toml):
        
    [[runners]]
      pre_clone_script = "echo $PATH; ls -la /usr/bin; env"
      
Une image appelée gitlab runner helper est utilisée pour cloner, et elle ne dipose pas de ssh par défaut.

Il est possible d'utiliser une image custom avec l'option:

    [[runners]]
      [runners.docker]
        helper_image = ".....:5000/.../../gitlab-ci-helper:0.1"
    
      