# Variables

Exemple de déclaration complète:

    variable vsphere_user{
      type          = "string"
      default       = "root"
      description   = "Username for vsphere"
    }
    
Avec prompt (ne pas définir de valeur par défaut):

    variable vsphere_user{
      type          = "string"
      description   = "Username for vsphere"
    }
    
Variables locales:
   
    locals {
      folder_name = "${var.root_path}/folder_name"
    }    
    
    # Pour utiliser une variable
    
    resource "vsphere_folder" "folder_cluster" {
      path = "${local.k8s-etcd_folder}"
      ...
    }
        
        
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
        