# Exécuter des commandes shell
  
Avec bash:
    
     - shell: update-ca-certificates
       args:
         executable: /bin/bash

Conditionnel avec stat: 
    
      - name: "Test docker network configuration"
        stat: path=/sys/class/net/docker0/
        register: dockerNetConfig
    
      - name: "Remove docker network configuration"
        shell: "iptables -t nat -F && ip link set docker0 down && ip link delete docker0"
        when: dockerNetConfig.stat.exists == True         