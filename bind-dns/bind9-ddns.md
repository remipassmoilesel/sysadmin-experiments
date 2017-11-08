# Activer DDNS sur BIND

## Configuration

Pour permettre de modifier dynamiquement un DNS:

    $ cd /etc/bind/
    $ dnssec-keygen -a HMAC-MD5 -b 128 -r /dev/urandom -n USER DDNS_UPDATE    
    
    $ cat Kddns_update.+157+20431.private
    
    Private-key-format: v1.3
    Algorithm: 157 (HMAC_MD5)
    Key: 5n6gUejOh0EN39gcETleHA==     # Partie à partager
    Bits: AAA=
    Created: 20171108112715
    Publish: 20171108112715
    Activate: 20171108112715

Ajouter la clef dans le fichier de clefs gérées par bind:
    
    $ vim /etc/bind/ddns.keys
     
     key DDNS_UPDATE {
             algorithm HMAC-MD5;
             secret "5n6gUejOh0EN39gcETleHA==";
     };
     
    $ chown root:bind /etc/bind/bind.keys 
    $ chmod 640 /etc/bind/bind.keys 
    
Inclure le fichier de clefs dans la configuration locale:

    $ vim /etc/bind/named.conf.local

    include "/etc/bind/ddns.keys";
    
    zone "infra.net" IN {
    
        ...
        
        allow-update { key DDNS_UPDATE; };

        ...
        
    }
    
Redémarrer Bind:

    $ systemctl reload bind9 && systemctl status bind9
    
## Test de fonctionnement

    $ vim batch.txt
    
    server 127.0.0.1
    update add machine3.infra.net. 86400 a 172.0.1.1
    show
    send
    
    $ nsupdate -v -k /etc/bind/ddns.keys batch.txt 

En cas de problème d'écriture:

    $ vim /etc/apparmor.d/usr.sbin.named
    
    /etc/bind/** r,
    /etc/bind/infra.net/** rw,
    
    $ systemctl restart apparmor
    $ sudo chown -R bind:bind /etc/bind
    
    
    
    
    
    
    
        