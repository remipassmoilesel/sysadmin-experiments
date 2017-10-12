# Auto index

Autoriser une liste de fichiers comme index:

    location / {
            autoindex on;
    }
    
Pour servir un dossier quelque soit le chemin (problèmes de /):

    location ~ .* {
            autoindex on;
    }

    

            