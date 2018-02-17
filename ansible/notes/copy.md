# Copie        
        
Copier un fichier du poste local au poste distant:
     
     - name: "Deploy application"
        copy:
          src: "/opt/safran-des-lices/target/safran-des-lices-0.0.1-SNAPSHOT.war"
          dest: "/opt/tomcat/webapps/vh_safranlices/ROOT.war"
        
Copier un fichier du poste distant au poste distant        
            
     - name: "Deploy application"
        copy:
          remote_src: yes
          src: "/opt/safran-des-lices/target/safran-des-lices-0.0.1-SNAPSHOT.war"
          dest: "/opt/tomcat/webapps/vh_safranlices/ROOT.war"        
        
Ecrire dans un fichier:        

    - name: "Specify master host name and adresses"
      copy:
        content: "{{ masterAddress }} {{ masterHostName }}\n"
        dest: /etc/hosts        
        
Copier tous les fichiers qui match un pattern:

    - name: copy over non-packaged checks
      copy: src={{ item }} dest={{ nagios_plugins_directory }} owner=root group=root mode=0755
      with_fileglob:
        - ../files/checks/*
      tags:
        - config        