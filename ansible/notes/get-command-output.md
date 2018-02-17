# Utiliser la sortie d'une commande
    
Exemple:    
    
    - name: Get public identity of poller server
      shell: "cat /etc/ssh/ssh_host_rsa_key.pub"
      register: poller_ssh_identity
      delegate_to: centreon-poller
      
Utiliser la sortie standard:      
      
    - name: Add poller identity to central known hosts for centreon user
      known_hosts:
        path: /var/spool/centreon/.ssh/known_hosts
        name: "{{ hostvars['centreon-poller']['ansible_host'] }}"
        key: "{{ hostvars['centreon-poller']['ansible_host'] }} {{ poller_ssh_identity.stdout }}"
        
Utiliser le code de retour:

    - name: Launch tunnel if necessary
      shell: "sudo -iu centreon /usr/local/tunnels/init-tunnel-{{ hostvars['centreon-poller']['ansible_host'] }}.sh"
      when: tunnel_launched.rc != 0              