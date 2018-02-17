# Commandes locales et commandes déléguées

## Commandes déportées

Il est possible d'éxecuter des commandes sur d'autres serveurs, en spécifiant un addresse et un utilisateur optionnel:

    - name: "Register hosts in Centreon master"
      shell: "/usr/bin/centreon -u {{ centreon_master_login }} -p {{ centreon_master_password }} -o HOST -a ADD -v \
                '{{ ansible_hostname }};{{ ansible_hostname }};{{ ansible_default_ipv4.address }};{{ centreon_host_template }};{{ centreon_poller_name }};{{ centreon_host_group }}'"
      delegate_to: "{{ centreon_master_address }}"
      remote_user: root
      ignore_errors: yes

## Commandes locales

Il est possible de déléguer l'éxécution d'une tâche à un autre hôte comme par exemple:

    - name: smoke test
      uri: url=http://{{ inventory_hostname }}/ status_code=200
      delegate_to: distant-host.com    
      
Ces tâches peuvent être déléguées à localhost:

    - name: smoke test
      uri: url=http://{{ inventory_hostname }}/ status_code=200
      delegate_to: localhost
      
On peut utiliser également `local_action`:
    
    - name: smoke test
      local_action: uri url=http://{{ inventory_hostname }}/ status_code=200          
