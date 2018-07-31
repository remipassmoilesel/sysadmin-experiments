# Utiliser des mots de passe avec Ansible


## Changement de mot de passe utilisateur

Créer un mot de passe crypté:

    $ sudo apt install whois
    $ mkpasswd --method=sha-512

Ensuite:

    - name: "Change root password"
      user:
        name: root
        password: "{{ vm_passwords.root }}"


## Stockage

Voir Ansible Vault ?
