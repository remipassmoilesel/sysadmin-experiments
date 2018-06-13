# Charts kubernetes


## Debug

Voir: 

    https://github.com/kubernetes/helm/blob/master/docs/chart_template_guide/debugging.md
    
Commandes:

    $ helm lint                       # vérifier le format du chart
    $ helm install --dry-run --debug  # voir ce qui sera installé, et les variables déclarées
    $ helm get manifest               # idem
    
Utiliser un chart:
  
    $ cd chart_dir
    $ helm dependency update    
    $ helm install . --name release-name
    
    
         