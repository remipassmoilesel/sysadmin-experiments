# Dockerfile

Copier un fichier:

    COPY testfile.txt /directory/
    
Créer un répertoire:

    RUN mkdir /directory    
    
Dockerfile minimaliste Node:

    FROM node:8.5.0-alpine
    
    RUN mkdir /server
    COPY index.js /server
    
    CMD node /server/index.js
    
    EXPOSE 80 8888 9999