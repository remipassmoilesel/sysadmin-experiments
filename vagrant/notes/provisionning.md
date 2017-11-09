# Provisionning

Pour effectuer des opérations sur la machine, il est possible d'utiliser des scripts.
Par exemple créer un fichier bootsrap.sh avec des instructions puis ajouter:
	
	config.vm.provision :shell, path: "bootstrap.sh"

Ensuite: 
	
	$ vagran up

Pour mettre à jour une machine existante en marche:

	$ vagrant reload --provision

Provisionning en ligne:

	config.vm.provision "shell", inline: <<-SHELL
		apt-get update
		apt-get install -y apache2
	SHELL

Il est possible d'utiliser d'autres outils comme Chef, Ansible, etc ...


