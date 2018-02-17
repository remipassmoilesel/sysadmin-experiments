# Commandes générales et commandes ad-hoc

Ping:

	$ ansible -m ping all --one-line -u ansible
	172.17.0.3 | SUCCESS => {"changed": false, "ping": "pong"}

Executer un programme sur une cible:

	$ ansible all -a "/bin/ls /"
	
Changer d'utilisateur:

    $ ansible all -u username -a "/bin/ls /"
	
Exécuter une commande shell sur une cible avec SH. Attention aux règles de quote:

    $ ansible all -m shell -a 'echo $TERM'

Elévation de privilèges (ansible_become_pass peut être spécifié dans host):

    $ ansible all -a "/bin/ls /root" -b --extra-vars "ansible_become_pass=ansible"

Obtenir des renseignements sur les serveurs:

	$ ansible all -m setup --tree /tmp/facts_servers/
	# les renseignements sont copiés dans le dossier /tmp/...

Envoyer un fichier:

    $ echo 'Hey hey !' > file-to-send.txt
    $ ansible all -m copy -a "src=file-to-send.txt dest=/tmp/sent-file.txt"
    $ ansible all -m shell -a "cat /tmp/sent-file.txt"

Installer un paquet (exemple pour Alpine, mais apt et yum disponibles):

    $ ansible all -m apk -a "name=openssh state=present"
    $ ansible all -m apk -a "name=openssh state=latest"
    $ ansible all -m apk -a "name=openssh state=absent"
    
Installer à partir d'un dépôt git:
 
    $ ansible all -m git -a "repo=git://foo.example.org/repo.git dest=/srv/myapp version=HEAD"
    
Gérer des services:

    $ ansible webservers -m service -a "name=httpd state=started"
    $ ansible webservers -m service -a "name=httpd state=restarted"
    $ ansible webservers -m service -a "name=httpd state=stopped"
    
Tâche en arrière plan, utiles pour éviter les timeout SSH:

    Voir http://docs.ansible.com/ansible/intro_adhoc.html#time-limited-background-operations 
    
    
    