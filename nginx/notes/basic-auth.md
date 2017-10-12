# Basic auth avec Nginx

Créer un fichier htpasswd:

    $ 🙂 sudo htpasswd -c /etc/nginx/.htpasswd exampleuser
    
    ou 
    
    $ 🙂 cd /etc/nginx && htpasswd -cb .htpasswd user password
    
Configurer Nginx:

    $ 🙂 sudo vim /etc/nginx/sites-enabled
    
       location / {
            auth_basic           "Attention, site hautement sécurisé";
            auth_basic_user_file /etc/nginx/.htpasswd;
        }
    
       # Il est possible de placer cette configuration dans 'server' également, pour
       # qu'elle soit utilisée pour toutes les locations      
    
Recharger Nginx:

    $ 🙂 sudo systemctl reload nginx     