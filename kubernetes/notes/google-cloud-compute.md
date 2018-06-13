# Utiliser Google Cloud Compute

Installation de l'interface CLI:

    $ export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
    $ echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    $ curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    $ sudo apt-get update && sudo apt-get install google-cloud-sdk

Initialisation (créer un compte au préalable):

    $ gcloud init

Configurer la région des projets (US moins chère):

    $ gcloud config set compute/region us-central1
    $ gcloud config set compute/zone us-central1-f
 
Créer un projet (le créer sur l'interface web peut permettre moins d'erreurs):

    $ gcloud projects create remipassmoilesel-kthw
    $ gcloud config set project remipassmoilesel-kthw
    
Pour créer un réseau, des machines, et installer kubernetes voir:

    https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-infrastructure-gcp.md
    
## Installation de kubernetes (notes brèves)

Objectif:

    $ gcloud compute instances list
    
    NAME         ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP      STATUS
    controller0  us-central1-f  n1-standard-1               10.240.0.10  XXX.XXX.XXX.XXX  RUNNING
    controller1  us-central1-f  n1-standard-1               10.240.0.11  XXX.XXX.XXX.XXX  RUNNING
    controller2  us-central1-f  n1-standard-1               10.240.0.12  XXX.XXX.XXX.XXX  RUNNING
    worker0      us-central1-f  n1-standard-1               10.240.0.20  XXX.XXX.XXX.XXX  RUNNING
    worker1      us-central1-f  n1-standard-1               10.240.0.21  XXX.XXX.XXX.XXX  RUNNING
    worker2      us-central1-f  n1-standard-1               10.240.0.22  XXX.XXX.XXX.XXX  RUNNING

Adresse publique:

    remipassmoilesel@LeBleuPresqueVert: ~/linux-utils master ⚡
    $ 🐼 gcloud compute addresses list kubernetes-the-hard-way                                                                                                                           [11:04:50]
    
    NAME                     REGION       ADDRESS         STATUS
    kubernetes-the-hard-way  us-central1  35.188.132.226  RESERVED


























