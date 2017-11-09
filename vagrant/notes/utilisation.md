
# Utilisation

Préparer un fichier de vm Vagrantfile:

	$ mkdir project && cd project
	$ vagrant init hashicorp/precise64

Lancer une vm, ou la redémarrer:

	$ vagrant up

Pour mettre à jour une machine après une modif du Vagrantfile:

	$ vagrant reload

Statut:

	$ vagrant status

Eteindre proprement:

	$ vagrant halt

Détruire une vm:

	$ vagrant destroy

Ouvrir une session ssh:

	$ vagrant ssh

Lister les box disponibles:

	$ vagrant box list