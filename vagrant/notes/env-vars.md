# Utiliser les variables d'environnement dans un Vagrantfile

Les variables doivent être exportées, par exemple à partir d'un fichier:

    export DOCKER_VAR_FILE="./../docker/local/composefiles/.env"
    source $DOCKER_VAR_FILE
    export $(cut -d= -f1 $DOCKER_VAR_FILE)

Ensuite utiliser ENV de ruby. Pour les afficher toutes:

    require 'pp'
    pp ENV

Pour les récupérer dans des variables globales:

    $vmAddress = ENV["MY_IP_ADD"]
    $hostSourceDirectory = ENV["HOST_SOURCE_DIRECTORY"]
    $hostDataDirectory = ENV["HOST_DATA_DIRECTORY"]
    $hostKeyDirectory = ENV["HOST_PRIVATE_KEY_DIRECTORY"]
    
    $vmSourceDirectory = ENV["CPOS_DIR"]
    $vmDataDirectory = ENV["DATA_DIR"]
    $vmKeyDirectory = ENV["VM_KEY_DIRECTORY"]
    
Pour vérifier si elles sont définies:

    def checkVars()

      raise Exception, "Variable $vmAddress undefined" if $vmAddress.to_s.empty?
      
      raise Exception, "Variable $hostSourceDirectory undefined"  if $hostSourceDirectory.to_s.empty?
      raise Exception, "Variable $hostDataDirectory undefined"    if $hostDataDirectory.to_s.empty?
      raise Exception, "Variable $hostKeyDirectory undefined"     if $hostKeyDirectory.to_s.empty?
    
      raise Exception, "Variable $vmSourceDirectory undefined"    if $vmSourceDirectory.to_s.empty?
      raise Exception, "Variable $vmDataDirectory undefined"      if $vmDataDirectory.to_s.empty?
      raise Exception, "Variable $vmKeyDirectory undefined"       if $vmKeyDirectory.to_s.empty?
    
    end    