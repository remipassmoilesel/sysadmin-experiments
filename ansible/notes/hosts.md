### /etc/ansible/hosts: liste des cibles

Source: http://docs.ansible.com/ansible/intro_inventory.html

## Spécifier es hôtes cibles

Exemple d'ajout de cibles:

	node1.address.fr:22
	
	[groupname]
	node2.address.fr:22
	node3.address.fr:443

Il est possible de définir des alias pour les cibles. Dans le cas ci-dessous, la cible pourra
être manipulée en utilisant 'jumper':

	jumper ansible_port=5555 ansible_host=192.0.2.50
	
Il est possible d'ajouter plusieurs cibles avec un pattern. Ici db-a.example.com, 
db-b.example.com, etc ...
	
	[databases]
    db-[a:f].example.com

Spécifier l'utilisateur pour la connexion ssh:

    node3.address.fr:443 ansible_user=mdehaan

## Variables

Spécifier des variables qui seront utilisables dans les playbooks (scripts ansible):

    host.domain.com http_port=303 maxRequestsPerChild=909
    
Ou pour appliquer des variables à un groupe:

    [southeast]
    domain-one.com
    domain-two.com

    [southeast:vars]
    some_server=foo.southeast.example.com
    halon_system_timeout=30
    self_destruct_countdown=60
    escape_pods=2

Il est possible de séparer les variables dans des fichiers différents au format YAML.
 Ces fichiers seront lu par Ansible:

    /etc/ansible/group_vars/group-name 
    /etc/ansible/host_vars/target-host-name

Les répertoires ci-dessus peuvent être créé dans les playbook également.

## Docker

Il est possible de déployer des playbooks directement dans un conteneur Docker.
Voir http://docs.ansible.com/ansible/intro_inventory.html#non-ssh-connection-types
