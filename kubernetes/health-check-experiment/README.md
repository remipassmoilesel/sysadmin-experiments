# Expérience sur le health check Kubernetes

Expérience menée sur un conteneur test, visant à comparer deux situations. Dans les deux situations un conteneur
expose:
- un service sur un port HTTP (80),
- un port HTTP (8888) permettant de vérifier l'état de santé du conteneur,
- un port HTTP (9999) permettant de rendre malade le conteneur pendant 10s puis de le tuer  

Les deux types de conteneurs:
- **A**: Où le conteneur test répercute immédiatement les erreurs ou les demandes d'arrêt sur le port de vérification de santé.
Il est toute de suite écarté du trafic et ne reçoit plus de requêtes, avant de s'arrêter 10 secondes plus tard. Pendant ce temps 
d'attente il serait par exemple possible d'implémenter un gracefully shutdown avec déconnexion des bases de données etc...
- **B**: Où le conteneur ne répercute pas tout de suite les erreurs sur le port de vérification de santé, et transmet
des requêtes erronées jusqu'à son extinction.  

Des tests ont été menés avec JMeter. 

## Test JMeter

Cluster Kubernetes utilisé:

- 3 contrôlleurs n'éxecutant pas de conteneur A ou B
- 3 worker avec 2G de mémoire RAM, 1 processeur

Conditions du test:

- 30 requêtes par seconde, soit plus de 2 000 000 de requêtes par jour
- 10 instances du service A et 10 instances du service B
- Extinction d'une instance de chaque service toutes les 2 secondes

Résultats:
- Sans extinctions d'instance, 0% d'erreurs 
- Une extinction d'instance toutes les 2 secondes A=3.27% B=4.33% d'erreurs

## Conclusion

La route de health check doit répercuter au plus tôt l'indisponibilité du conteneur afin qu'il ne reçoive plus de requêtes,
ce qui peut permettre aussi d'éffectuer des opérations avant destruction du conteneur.

## Remarques

- Toujours penser à désactiver les logs, ils peuvent créer de très gros problèmes (ralentissements, erreurs, etc...)