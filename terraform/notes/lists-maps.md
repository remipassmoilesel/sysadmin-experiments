# Listes et maps

## Listes

Obtenir la taille d'une liste:

    count = "${length(var.vm_names)}"

Obtenir un élement d'une liste:

    name = "${element(var.vm_names, count.index)}"
    
## Maps    
    
Obtenir la valeur d'une map:

    ipv4_address = "${lookup(var.vm_ips, element(var.vm_names, count.index))}"