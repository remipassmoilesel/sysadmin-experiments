# Créer des certificats SSL

Créer une autorité de certification:  

      - name: "Create root CA certificate"
        command: openssl genrsa -out {{ vars.kubernetes_cert_dir }}/rootCA.key 2048
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/rootCA.key"
    
      - name: "Sign certificate"
        command: openssl req -x509 -new -nodes -key {{ vars.kubernetes_cert_dir }}/rootCA.key -sha512 \
                    -days 1024 -out {{ vars.kubernetes_cert_dir }}/rootCA.pem \
                    -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/rootCA.pem"

Créer des certificats et les signer:
    
      - name: "Create server certificate"
        command: openssl genrsa -out {{ vars.kubernetes_cert_dir }}/server.key 2048
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/server.key"
    
      - name: "Create server certificate request"
        command: openssl req -new -key {{ vars.kubernetes_cert_dir }}/server.key \
                    -out {{ vars.kubernetes_cert_dir }}/server.csr \
                    -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/server.csr"
    
      - name: "Sign server certificate"
        command: openssl x509 -req -in  {{ vars.kubernetes_cert_dir }}/server.csr \
                    -CA  {{ vars.kubernetes_cert_dir }}/rootCA.pem \
                    -CAkey  {{ vars.kubernetes_cert_dir }}/rootCA.key -CAcreateserial \
                    -out {{ vars.kubernetes_cert_dir }}/server.crt -days 1024 -sha512
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/server.crt"
    
      - name: "Create client1 certificate"
        command: openssl genrsa -out {{ vars.kubernetes_cert_dir }}/client1.key 2048
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/client1.key"
    
      - name: "Create client1 certificate request"
        command: openssl req -new -key {{ vars.kubernetes_cert_dir }}/client1.key \
                    -out {{ vars.kubernetes_cert_dir }}/client1.csr \
                    -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/client1.csr"
    
      - name: "Sign client1 certificate"
        command: openssl x509 -req -in  {{ vars.kubernetes_cert_dir }}/client1.csr \
                    -CA  {{ vars.kubernetes_cert_dir }}/rootCA.pem \
                    -CAkey  {{ vars.kubernetes_cert_dir }}/rootCA.key -CAcreateserial \
                    -out {{ vars.kubernetes_cert_dir }}/client1.crt -days 1024 -sha512
        args:
          creates: "{{ vars.kubernetes_cert_dir }}/client1.crt"