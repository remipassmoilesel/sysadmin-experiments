# Modèles de configuration

Créer un fichier de configuration avec des variables:

    apiVersion: v1
    clusters:
    - cluster:
        certificate-authority: {{ vars.kubernetes_cert_dir }}/rootCA.pem
        server: https://{{ vars.master1_address }}
      name: cluster1
    contexts:
    - context:
        cluster: cluster1
        user: admin
      name: cluster1context
    current-context: cluster1context
    kind: Config
    preferences: {}
    users:
    - name: admin
      user:
        client-certificate: {{ vars.kubernetes_cert_dir }}/client1.crt
        client-key: {{ vars.kubernetes_cert_dir }}/client1.key
        token: 8morVbX8jD1SKu7wuoCDIKo8ZOI5q3uY
        
Puis ajouter dans le playbook:

    - hosts: ...
      vars:
        master1_address: "192.168.0.35"
        kubernetes_binaries_base_path: "/opt/"
        kubernetes_binaries_dir: "/opt/kubernetes"
        kubernetes_cert_dir: "/srv/kubernetes/certificates"
            
      tasks:
        - name: "Add config to kubelet"
        template:
          src: "config/kube-config"
          dest: "/var/lib/kubelet/kubeconfig"       
          
## Tout un répertoire:
    
Voir: https://docs.ansible.com/ansible/2.6/plugins/lookup/filetree.html    
    
    - name: Create directories
      file:
        path: /web/{{ item.path }}
        state: directory
        mode: '{{ item.mode }}'
      with_filetree: web/
      when: item.state == 'directory'
    
    - name: Template files
      template:
        src: '{{ item.src }}'
        dest: /web/{{ item.path }}
        mode: '{{ item.mode }}'
      with_filetree: web/
      when: item.state == 'file'
