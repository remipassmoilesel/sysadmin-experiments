# Docker registry

Lancer un registry de test:
    
    #!/bin/bash
    
    docker rm registry-test || :
    
    docker run -d \
            -v /etc/docker-test/registry:/etc/docker/registry \
            --restart always \
            -v /home/registry-test:/var/lib/registry \
            -p 5001:5001 --name registry-test registry:2.6

        
Exemple de configuration:        
        
    version: 0.1
    log:
      level: info
      fields:
        service: registry
    storage:
      cache:
        blobdescriptor: inmemory
      filesystem:
        rootdirectory: /var/lib/registry
    http:
      addr: :5001
      host: https://domain.com:5001
      secret: secret
      tls:
        certificate: /etc/docker/registry/certs/domain.crt
        key: /etc/docker/registry/certs/domain.key
      headers:
        X-Content-Type-Options: [nosniff]
      debug:
        addr: :5002
    health:
      storagedriver:
        enabled: true
        interval: 10s
        threshold: 3
       
            
Lancer un gc (des images doivent être présentes sur le registry ou une erreur sera levée):

     $ docker exec -ti registry-test /bin/sh
     $ /bin/registry garbage-collect --dry-run /etc/docker/registry/garbage-collect.yml
           
           
            
            
            
            
            
            
