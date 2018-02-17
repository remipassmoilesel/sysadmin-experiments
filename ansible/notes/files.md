# Fichiers

Créer un dossier:

      - name: "Create kubernetes binaries directory"
        file:
          path: "{{ vars.kubernetes_binaries_dir }}"
          state: directory
 
Désarchiver un fichier présent sur la machine distante. Si 'creates' existe, l'opération n'est 
pas effectuée.         

      - name: "Extract kubernetes binaries"
        unarchive:
          remote_src: yes
          src: "{{ vars.kubernetes_binaries_base_path }}/kubernetes.tar.gz"
          dest: "{{ vars.kubernetes_binaries_base_path }}"
          creates: "{{ vars.kubernetes_binaries_dir }}/README.md"

           