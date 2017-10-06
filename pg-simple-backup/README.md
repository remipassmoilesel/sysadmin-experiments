# Backup simplifié pour Postgres

Source: https://wiki.postgresql.org/wiki/Automated_Backup_on_Linux

## Installation

Copier les fichiers: 

    $ mkdir -p /opt/pg-backup/backup
    $ mv pg_backup.sh /opt/pg-backup/
    $ mv pg_backup.config /opt/pg-backup/

Editer la configuration si nécéssaire:
    
    $ vim /opt/pg-backup/pg_backup.config 
    
L'utilisateur doit avoir un mot de passe:    
    
    $ sudo -iu postgres psql -c "ALTER USER \"postgres\" WITH PASSWORD 'postgres';"
    
Lancement:

    $ sudo -iu postgres PGPASSWORD="postgres" /opt/pg-backup/pg_backup.sh     