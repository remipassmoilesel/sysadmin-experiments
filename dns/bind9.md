# DNS avec bind9

Ressources:

- https://mondedie.fr/d/5946-Tuto-Mettre-en-place-un-serveur-DNS-autoritaire-avec-Bind9-et-DNSSEC
- https://www.supinfo.com/articles/single/1709-mise-place-serveur-dns-avec-bind9
- https://www.supinfo.com/articles/single/1715-dynamic-dns-avec-bind9-isc-dhcp-server
- http://docs.ansible.com/ansible/latest/nsupdate_module.html
- http://wiki.goldzoneweb.info/creation_d_une_zone


## Installation

    $ sudo apt install bind9 dnsutils
    
## Configuration

Dans le fichier de configuration principal, ajouter les options:

    $ vim /etc/bind/named.conf.options
    
    options {
       directory "/var/cache/bind";
    
       # Activer DNSSEC
       dnssec-enable yes;
       dnssec-validation auto;
       auth-nxdomain no; # RFC1035
    
       listen-on { any; };
       listen-on-v6 { any; };
    
       # Autoriser les requêtes récursives locales uniquement
       allow-recursion { 127.0.0.1; ::1; };
    
       # Ne pas transférer les informations des zones aux DNS secondaires
       allow-transfer { none; };
    
       # Ne pas autoriser la mise à jour des zones maîtres
       allow-update { none; };
    
       version none;
       hostname none;
       server-id none;
    };
    
Fichier de configuration local, déclarer la zone:

    # vim /etc/bind/named.conf.local
    
    zone "infra.net" IN {
    
            # Zone de type maître
            type master;
    
            # Fichier de zone
            file "/etc/bind/infra.net/db.infra.net";
    
            # On autorise le transfert de la zone aux serveurs DNS secondaires
            allow-transfer { 217.70.177.40; 213.186.33.199; 127.0.0.1; ::1; };
    
            # On autorise tout le monde à envoyer des requêtes vers cette zone
            allow-query { any; };
    
            # Prévenir les serveurs DNS secondaires qu'un changement a été effectué dans la zone maître
            notify yes;
    };    
    
Créer un répertoire pour la zone:

    $ mkdir /etc/bind/infra.net
    
Créer un fichier de zone, puis ajouter la configuration de la zone:
    
    $ vim /etc/bind/infra.net/db.infra.net
        
    ; ZONE : infra.net
    ; ------------------------------------------------------------------
    $TTL 7200       ; Durée en seconde de validité des enregistrements
    
    ; ns1.infra.net. = Nom du serveur primaire
    ; hostmaster.infra.net. = Mail du contact technique, le premier . sera remplacé par @ 
    @       IN      SOA    ns1.infra.net. hostmaster.infra.net. (
                                            2014102001 ; Serial: incrémenter à chaque changement: AAAAMMJJXX ou XX est un numéro de changement
                                            14400      ; Refresh
                                            3600       ; Retry
                                            1209600    ; Expire - 1 week
                                            86400 )    ; Minimum
    
    ; NAMESERVERS
    
    @                   IN                NS                   ns1.infra.net.
    @                   IN                NS                   ns6.gandi.net. ; DNS secondaire esclave
    
    
Puis ajouter les enregistrements:
    
    $ vim /etc/bind/infra.net/db.infra.net
    
    ; Enregistrements A/AAAA
    
    ; @ == $ORIGIN défini le suffixe des noms non qualifié
    ; Avec @ 192.168.0.65, 'machine' deviendra 'machine1.infra.net'
    
    @                   IN                A                    10.0.2.15
    @                   IN                AAAA                 fe80::a4:a0ff:fef1:db6e
    
    hostname            IN                A                    10.0.2.15
    hostname            IN                AAAA                 fe80::a4:a0ff:fef1:db6e
    
    ns1                 IN                A                    10.0.2.15
    ns1                 IN                AAAA                 fe80::a4:a0ff:fef1:db6e
    
    ; Sous-domaines - Serveur web
    www                 IN                CNAME                hostname
    blog                IN                CNAME                hostname
    forum               IN                CNAME                hostname
    
    ; Autre machines
    machine1            IN                A                    10.0.1.138
    machine1            IN                AAAA                 fe80::82ee:73ff:feb6:97cc

Redémarrer Bind:

    $ systemctl reload bind9 && systemctl status bind9
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    