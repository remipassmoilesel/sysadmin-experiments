# Utiliser Kvm, libvirt, virt-manager

Sources: 
- https://www.zenzla.com/linux/1462-la-virtualisation-avec-kvm-libvirt-et-virt-manager.html
- http://www.thegeekstuff.com/2014/10/linux-kvm-create-guest-vm/
- https://www.centos.org/docs/5/html/5.2/Virtualization/chap-Virtualization-Managing_guests_with_virsh.html

## Installation

Vérifier la compatibilité procésseur:

    $ egrep '^flags.*(vmx|svm)' /proc/cpuinfo
    # Si pas de retour, processeur non compatible    

Installer kvm et comparses:    
  
    $ sudo apt-get install kvm qemu-kvm libvirt-bin virtinst
    $ sudo apt-get install virt-manager   # Interface graphique, possibilité de gérer des 
                                          # serveurs distants
    
Ajouter son utilisateur aux bon groupes:

    $ usermod -a -G libvirtd remipassmoilesel
    $ usermod -a -G kvm remipassmoilesel
    $ sudo reboot # logout / login ne suffit pas

## Console virsh

Connexion:

    $ virsh -c qemu:///system
    
Commande courantes:    

    virsh # list
    virsh # list --inactive
    virsh # list --all
    virsh # start VmDebian
    virsh # reboot VmDebian
    virsh # shutdown VmDebian
    virsh # destroy VmDebian
    virsh # dominfo VmDebian
    virsh # nodeinfo

## Créer une machine virtuelle
        
/!\ non testé        
        
Exemple de commande de création:        
        
    # virt-install \
     -n myRHELVM1 \
     --description "Test VM with RHEL 6" \
     --os-type=Linux \
     --os-variant=rhel6 \
     --ram=2048 \
     --vcpus=2 \
     --disk path=/var/lib/libvirt/images/myRHELVM1.img,bus=virtio,size=10 \
     --graphics none \
     --cdrom /var/rhel-server-6.5-x86_64-dvd.iso \
     --network bridge:br0             
     
Création à partir d'un fichier XML:
    
    $ virsh -c qemu:///system create /tmp/NewVmDebian.xml     
    
    