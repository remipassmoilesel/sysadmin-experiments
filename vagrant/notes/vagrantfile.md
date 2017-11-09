
# Vagrantfile

    Voir les exemples du dossier

## Commencer

Créer un fichier basic:

	$ vagrant init

Squelette de fichier de config (2 est la version):

	Vagrant.configure("2") do |config|
		...
	end

Choisir une box pour commencer:

	config.vm.box = "hashicorp/precise64"
	config.vm.box_version = "1.1.0"

Dossiers partagés: par défaut vagrant monte le dossier courant dans /vagrant.
Mais pour ajouter un dossier:

	config.vm.synced_folder "src/", "/srv/website"

Il est possible de partager des fichiers avec rsync, sans additions invités.

## Multi machine

Il est possible de créer plusieurs machines à la fois:

	Vagrant.configure("2") do |config|
	  config.vm.provision "shell", inline: "echo Hello"

	  config.vm.define "web" do |web|
	    web.vm.box = "apache"
	  end

	  config.vm.define "db" do |db|
	    db.vm.box = "mysql"
	  end
	end

Toutes les commandes utilisent ensuite le nom de la machine:

	$ vagrant up web
	$ vagrant halt web
	...

