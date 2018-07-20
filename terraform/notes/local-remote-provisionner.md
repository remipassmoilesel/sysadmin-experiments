# Local and remote provisionner

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
    
