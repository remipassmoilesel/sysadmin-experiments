# Commandes shell / import

Executer un script shell:

    $ vim script.js
    
    print("Server status: ")
    print(JSON.stringify(db.serverStatus(), null, 2))

    $ mongo host:port ./script.js
    
    