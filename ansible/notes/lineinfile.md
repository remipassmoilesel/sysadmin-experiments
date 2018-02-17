# Modifier des fichiers de configuration

Ajouter ou remplacer une ligne:    
    
    - lineinfile:
        path:  /etc/nagios/nrpe.cfg
        state: present
        line: "allowed_hosts=127.0.0.1, {{ centreon_master_address }}"
        regexp: '^allowed_hosts='
        
En cas de modification de ligne, la regex doit correspondre à la ligne non modifiée et à la ligne modifiée
pour ne pas ajouter la ligne systématiquement aux prochaines éxecutions du playbook.

    - name: Make postgresql listen on all addresses
      lineinfile:
        path: /etc/postgresql/9.5/main/postgresql.conf
        regexp: "^#?listen_addresses.*"     # '#?' > match commented and uncommented line
        line: "listen_addresses = '*'"
        state: present        