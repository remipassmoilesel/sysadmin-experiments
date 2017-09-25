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
        