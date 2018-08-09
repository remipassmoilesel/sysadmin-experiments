# Erreurs courantes

## TypeError: load_config() got an unexpected keyword argument 'config_dict'
    
    Traceback (most recent call last):              
      File "/usr/local/bin/docker-compose", line 11, in <module>
        sys.exit(main())                                                                                                                                                                                               
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 71, in main
        command()
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/main.py", line 124, in perform_command                                                
        project = project_from_options('.', options)                                                                                                                                                                 
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/command.py", line 41, in project_from_options                                                                                                           
        compatibility=options.get('--compatibility'),
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/command.py", line 121, in get_project
        host=host, environment=environment     
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/command.py", line 92, in get_client                                                                                                                     
        environment=environment, tls_version=get_tls_version(environment)
      File "/usr/local/lib/python2.7/dist-packages/compose/cli/docker_client.py", line 127, in docker_client
        client = APIClient(**kwargs)                                                                                                                 
      File "/usr/local/lib/python2.7/dist-packages/docker/api/client.py", line 113, in __init__                                                                                                                      
        config_dict=self._general_configs                                                                                                                                                                              
    TypeError: load_config() got an unexpected keyword argument 'config_dict'

Ou tout autre erreur soudaine avec Docker-compose, ou en utilisant Ansible. DockerPy intérfère avec 
docker-compose

    $ sudo pip uninstall -y dockerpy
    $ sudo pip install -y docker