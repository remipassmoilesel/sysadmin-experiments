# Erreurs courantes

## Debug

    $  TF_LOG=DEBUG terraform apply   


## Erreurs

### A specified parameter was not correct: spec.identity.hostName

    Error applying plan:
    
    4 error(s) occurred:
    
    * vsphere_virtual_machine.vm_iac[2]: 1 error(s) occurred:
    
    * vsphere_virtual_machine.vm_iac.2: A specified parameter was not correct: spec.identity.hostName
    * vsphere_virtual_machine.vm_iac[1]: 1 error(s) occurred:
    
    * vsphere_virtual_machine.vm_iac.1: A specified parameter was not correct: spec.identity.hostName
    * vsphere_virtual_machine.vm_iac[0]: 1 error(s) occurred:
    
    * vsphere_virtual_machine.vm_iac.0: A specified parameter was not correct: spec.identity.hostName
    * vsphere_virtual_machine.vm_iac[3]: 1 error(s) occurred:
    
    * vsphere_virtual_machine.vm_iac.3: A specified parameter was not correct: spec.identity.hostName
    
    Terraform does not automatically rollback in the face of errors.
    Instead, your Terraform state file has been partially updated with
    any resources that successfully completed. Please address the error
    above and apply again to incrementally change your infrastructure.

Le nom des machines est incorrect (pas de _ - etc ...)


### invalid guest ID "otherLinux64Guest" for clone. Please set it to "other3xLinux64Guest"

    Refreshing Terraform state in-memory prior to plan...
    The refreshed state will be used to calculate this plan, but will not be
    persisted to local or remote state storage.
    
    data.vsphere_datacenter.dc: Refreshing state...
    data.vsphere_host.host: Refreshing state...
    data.vsphere_resource_pool.pool: Refreshing state...
    data.vsphere_network.network: Refreshing state...
    data.vsphere_virtual_machine.template: Refreshing state...
    data.vsphere_datastore.datastore: Refreshing state...
    
    Error: Error refreshing state: 1 error(s) occurred:
    
    * vsphere_virtual_machine.integration01: 1 error(s) occurred:
    
    * vsphere_virtual_machine.integration01: invalid guest ID "otherLinux64Guest" for clone. Please set it to "other3xLinux64Guest"
    
    
L'invité cible ou l'invité à cloner est mal configuré. 

Voir:

    VSphere GUI > vm > Modifier les paramètres > Options VM > Options générales > Version OS client
    
Voir la liste des identifiants:

    https://pubs.vmware.com/vsphere-6-5/index.jsp?topic=%2Fcom.vmware.wssdk.apiref.doc%2Fvim.vm.GuestOsDescriptor.GuestOsIdentifier.html    