
# Réseau

Pour prendre en compte les modifications réseau il est souvent nécéssaire d'arrêter puis de redémarrer les machines
(vagrant halt, vagrant up)

Transfert de port:

	config.vm.network "forwarded_port", guest: 80, host: 8080

Rendre une machine accessible sur un réseau privé:

	config.vm.network "private_network", type: "dhcp" 	# adresse obtenur par dhcp, peut nécéssiter une configuration supplémentaire
	config.vm.network "private_network", ip: "192.168.50.4" # adresse fixe 

Rendre une machine accessible sur un réseau "public":

	config.vm.network "public_network" 			# dhcp
	config.vm.network "public_network", ip: "192.168.0.17"	# adresse fixe

L'accés public se fait par bridge. Vagrant demande sur quelle interface il doit faire le pont. 
Pour spécifier l'interface par défaut:

	config.vm.network "public_network", ip: "192.168.0.17", bridge: "wlan0"

Pour déterminer les adresses ip il est possible de se connecter en ssh (vagrant ssh) pour observer 
les interfaces de la machine virtuelle.

Il est possible de configurer le réseau manuellement en désactivant la conf. auto et en utilisant le 
provisionning par shell.

Configurer le fichier host de l'hôte automatiquement (ajouter une entrée pour la machine virtuelle
par exemple):

	$ vagrant plugin install vagrant-hostmanager

