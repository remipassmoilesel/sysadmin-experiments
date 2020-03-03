# Kustomize

## Ressources

- Exemples: https://github.com/kubernetes-sigs/kustomize/tree/master/examples


## Utilisation 

Installation: 

    $ curl -s "https://raw.githubusercontent.com/\
      kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash


Changer le nom et le tag d'une image docker en ligne de commande:

    $ kustomize edit set image nginx:$MY_NGINX_VERSION
