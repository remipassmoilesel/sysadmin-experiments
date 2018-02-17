# Playbook de restauration de données Postgres

## Insérer des données d'exemple

Changer le mot de passe, se connecter et créer une base exemple:

    $ sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD 'postgres';"
    $ pgcli -h localhost -U postgres -W
    $ create database sports

Télécharger et importer des données:
    
    $ wget http://www.sportsdb.org/modules/sd/assets/downloads/sportsdb_sample_postgresql.zip
    $ unzip sportsdb_sample_postgresql.zip
    $ sudo -u postgres psql sports < sportsdb_sample_postgresql_20080304.sql
    
Exporter toutes les bases de données présentes:

    $ sudo -u postgres pg_dumpall > db_sport.sql
    $ gzip db_sport.sql
    
## Lancer une restauration    
    
    $ ansible-playbook -i inventory.cfg recovery.yml --ask-pass