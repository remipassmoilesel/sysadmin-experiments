# Action conditionnelles

## Option 'creates'

Souvent les plugins ansibles proposent une option 'creates' qui permet de n'éxécuter l'action
que si le nom de fichier spécifié n'existe pas.

## Stat

Avec stat: 
    
      - name: "Test docker network configuration"
        stat: path=/sys/class/net/docker0/
        register: dockerNetConfig
    
      - name: "Remove docker network configuration"
        shell: "iptables -t nat -F && ip link set docker0 down && ip link delete docker0"
        when: dockerNetConfig.stat.exists == True

## Expressions ternaires

      set_fact:
        keepalived_state: "{{ 'MASTER' if groups.keepalived.index(inventory_hostname) == 0 else 'BACKUP' }}"
