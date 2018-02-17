# Configuration du daemon docker

Exemple:

    $ vim /etc/docker/daemon.json

    {
        "insecure-registries": ["domain.net:5000"],
        "dns": ["10.0.0.2", "10.0.0.1", "8.8.8.8", "8.8.4.4"]
    }

