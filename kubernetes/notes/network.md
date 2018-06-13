# Réseau

Voir: https://www.youtube.com/watch?v=WwQ62OyCNz4

Concept: chaque pod possède sa propre adresse IP. 

## Composants

- **kubenet**: plugin réseau par défaut, ne créé qu'un interface cbr0 (normalement). Tourne sur tous 
les noeuds d'un cluster.

- **kube-proxy**: permet l'abstraction réseau kubernetes concernant les services et pods en
faisant du port forwarding, etc ... Peut permettre du DNS avec kubedns.                                                 

## Communication pod à pod (interne)
 
Plusieurs solutions:

- **Flat routed network**: le routeur est configuré pour servir les pods. Plus efficient.
- **Overlay network**: tunnel avec réseau virtuel. Les données nécéssaires au routage sont stockées dans
ETCD (vxlan)

### Solutions vxlan

- **Flannel**: réputée simple
- **Calicot**: propose de la gestion de droits pour sécuriser le réseau

## Communication externe

Grâce aux services. Plusieurs types, voir `vocabulary.md`

Voir aussi https://kubernetes.io/docs/concepts/services-networking/service/