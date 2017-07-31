# Brouillon

## Variables

Demander une variable à la planification:

    variable "vsphere_user" {}
    
Utiliser des variables dans un fichier séparé:

    $ vim .tfvars
    
    variable "var" {
      vsphere_user = "*****"
      vsphere_password = "******"
      vsphere_server = "*****"
    }

Le fichier est souvent nommé .tfvars, mais il peut être nommé arbitrairement, tous les fichiers '.tf' sont 
chargés au lancement.

## Autres

Executer une commande locale (sur la machine qui éxecute terraform)

    provisioner "local-exec" {
        command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
    }
    
Exécuter une commande distante:

    provisioner "remote-exec" {
        inline = [
        "sudo apt-get -y update",
        "sudo apt-get -y install nginx",
        "sudo service nginx start"
        ]
    }