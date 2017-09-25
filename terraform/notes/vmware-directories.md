# Dossiers VMWare

Pour créer des dossiers:

    resource "vsphere_folder" "folder_name" {
      path = "folder_name"
      datacenter = "datacenter1"
    }

Pour créer des sous dossiers, ne pas oublier d'attendre que le parent soit créer: 
    
    resource "vsphere_folder" "subfolder" {
      path = "fodler/name/subfolder"
      datacenter = "datacenter1"
      depends_on = ["vsphere_folder.folder_name"]
    }
