# Utiliser terraform avec vsphere

/!\ Fichier obsolète après mise à jour du provider

Voir: https://www.hashicorp.com/blog/a-re-introduction-to-the-terraform-vsphere-provider

Créer un fichier credentials.tf:


    variable vsphere_password{
      description   = "Password for vsphere"
      type          = "string"
      default       = "***************"
    }
    
    variable vsphere_user{
      description   = "Username for vsphere"
      type          = "string"
      default       = "root"
    }
    
    variable vsphere_server_url{
      description   = "URL for vsphere"
      type          = "string"
      default       = "vccloud.domain.net"
    }

Configuration du provider:

    # Configure the VMware vSphere Provider
    provider "vsphere" {
      user           = "${var.vsphere_user}"
      password       = "${var.vsphere_password}"
      vsphere_server = "${var.vsphere_server}"
    
      # if you have a self-signed cert
      allow_unverified_ssl = true
    }

Créer un dossier Vsphere:

    # Create a folder
    resource "vsphere_folder" "mesos-cluster-1" {
      path = "mesos-cluster-1"
    }
