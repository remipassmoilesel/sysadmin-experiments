# Debugger un script ansible

Ajouter 'strategy: debug':

    - hosts: etcd_cluster
      strategy: debug
      vars_files:
      - vars.yaml
      roles:
      - setup-etcd
      
Puis lors d'un échec une console s'ouvre. Commandes possible:

    > p task      
    > p task.args 
    > p vars     
    > p vars['ansible_all_ipv4_addresses']
    > p vars['groups']['etcd_cluster']
    > p vars['groups']['etcd_cluster'][0]
    > p vars['hostvars'][vars['groups']['kube-master'][0]]
    > p vars['hostvars'][vars['groups']['kube-master'][0]]['inventory_hostname']

Afficher des variables avec une commande adhoc:

    $ ansible -m debug -a "var=hostvars[inventory_hostname]"
    
Afficher des variables dans un playbook:

    - debug:
      msg: "{{ hostvars[vars['groups']['kube-master'] }}"
    
Enregistrer tous les facts disponibles:

    $ ansible -i inventory.cfg all -m setup --tree /tmp/facts        