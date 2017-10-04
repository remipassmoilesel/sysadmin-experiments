# Erreurs courantes

En cas d'erreur:

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

Le nom des machines peut être incorrect (pas de _ - etc ...)