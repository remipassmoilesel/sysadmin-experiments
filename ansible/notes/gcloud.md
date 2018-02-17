# Utiliser Ansible avec Google Cloud

Installation de la lib cloud:

    $ pip install apache-libcloud
    
Télécharger une identité au format JSON:
- Voir https://support.google.com/cloud/answer/6158849?hl=en&ref_topic=6262490#serviceaccounts
- Se rendre sur: https://console.cloud.google.com/apis/credentials/serviceaccountkey?project=remipassmoilesel-kthw-177308
- Sélectionner `Créer une clef de compte de service`
- Sélectionner `Compute engine default service`
- Enregister la clef au format JSON