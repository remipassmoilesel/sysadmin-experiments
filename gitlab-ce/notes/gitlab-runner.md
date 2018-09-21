# Gitlab runner

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


## Cloner en SSH

Gitlab utilise une image helper pour cloner les modules, basée sur Alpine Linux. Si des dépôts doivent être clonés en SSH,

    
    concurrent = 5
    check_interval = 0
    
    [[runners]]
      name = "gitlab-runner-01"
      url = "https://192.168.XX.XX/"
      token = "XXXXXXXX"
      executor = "docker"
    
      # The command below is used to allow ssh clone
      pre_clone_script = "apk update && apk add openssh-client && mkdir -p /root/.ssh/ && ssh-keyscan -H 192.168.XX.XX >> /root/.ssh/known_hosts"    
    
      ...


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
    

Il est possible également d'appeler une commande pre-clone pour installer un client SSH:


### Checking for job: forbidden

    ERROR: Checking for jobs... forbidden               runner=a6f756be
    ERROR: Checking for jobs... forbidden               runner=a6f756be
    ERROR: Runner https://gitlab.locala6f756be006d1a3bb27eb1313f3cc4 is not healthy and will be disabled!
    All workers stopped. Can exit now                   builds=0

Ajouter les adresses IP des runners en whiteliste de rackattack (meilleure solution ?)

    gitlab_rails['rack_attack_git_basic_auth'] = {
      'enabled' => true,
      'ip_whitelist' => ["172.16.0.1", "172.16.0.2", "172.16.0.3", "172.16.0.4", "172.16.0.5", "172.16.0.6", "172.16.0.7", "172.16.0.8", "172.16.0.9"],
      'maxretry' => 10,
      'findtime' => 60,
      'bantime' => 3600
    }
    

### Erreur 500 sur la manipulation des pipelines

    
    ActionView::Template::Error (bad decrypt):
        4: 
        5: - id = variable&.id
        6: - key = variable&.key
        7: - value = variable&.value
        8: - is_protected = variable && !only_key_value ? variable.protected : false
        9: 
       10: - id_input_name = "#{form_field}[variables_attributes][][id]"
      app/views/ci/variables/_variable_row.html.haml:7:in `_app_views_ci_variables__variable_row_html_haml___2623095548269879429_69848920190020'
      app/views/ci/variables/_index.html.haml:9:in `block in _app_views_ci_variables__index_html_haml__3729429806748550900_69848806226200'
      app/views/ci/variables/_index.html.haml:8:in `each'
      app/views/ci/variables/_index.html.haml:8:in `each'
        
        
    
    ==> /var/log/gitlab/gitlab-rails/production.log <==
    
    OpenSSL::Cipher::CipherError (bad decrypt):
      /opt/gitlab/embedded/lib/ruby/gems/2.4.0/gems/encryptor-3.0.0/lib/encryptor.rb:98:in `final'
      /opt/gitlab/embedded/lib/ruby/gems/2.4.0/gems/encryptor-3.0.0/lib/encryptor.rb:98:in `crypt'
      /opt/gitlab/embedded/lib/ruby/gems/2.4.0/gems/encryptor-3.0.0/lib/encryptor.rb:49:in `decrypt'
      /opt/gitlab/embedded/lib/ruby/gems/2.4.0/gems/attr_encrypted-3.1.0/lib/attr_encrypted.rb:240:in `decrypt'
      /opt/gitlab/embedded/lib/ruby/gems/2.4.0/gems/attr_encrypted-3.1.0/lib/attr_encrypted.rb:329:in `decrypt'

Il y a un problème sur la gestion du chiffrage des variables gitlab ci.
Solutions possible:

    $ gitlab-rails dbconsole
    $ DELETE FROM ci_variables
    
Ensuite redéfinir les variables de pipeline de projets.

Voir: https://gitlab.com/gitlab-org/gitlab-ce/issues/13590
