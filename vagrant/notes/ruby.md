# Ruby

Les Vagrantfile sont des fichiers Ruby.

## Executer 

Executer un fichier test:

    ruby test.rb  

## Variables

Déclarer des variables:

    # Master address and host name
    masterAddress       = "192.168.0.40"
    masterHostName      = "master-jessie.mesos"
    
    # Enable a slave node
    enableSlaveNode     = true
      
Utiliser des variables:

    master.vm.network "public_network", ip: masterAddress
    
    master.vm.provision "shell", inline: <<-SHELL
        echo "Setting up master with address:             #{masterAddress}"    
    SHELL
    
Accéder aux variables d'environnement:

    require 'pp'
    pp ENV
    pp ENV["BYOBU_ACCENT"]    
    
## Structures    
    
Instructions conditionnelles:

    if enableSlaveNode == true
      ...
    end
    
Fonctions:

    normalVar = true
    $globalVar = true
    
    def functionName(var1, var2)
      # les variables globales sont accessibles
      raise Exception, "Variable $globalVar undefined" if $globalVar.to_s.empty?
      
      # mais pas les normales
      raise Exception, "Variable normalVar undefined" if normalVar.to_s.empty?
    end
    
    functionName("hey", "ho")
    
## Utilitaires

Pretty Printer:

    require 'pp'
    pp ENV