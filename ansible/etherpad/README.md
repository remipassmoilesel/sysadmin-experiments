# Etherpad installation

This playbook directory should be placed inside a valid and configured etherpad repository.

## How to use

Clone:

    $ git clone https://github.com/ether/etherpad-lite
    $ cd etherpad-lite

Copy playbook dir:

    $ cp ~/../sysadmin-experiments/ansible/etherpad ansible

Configure:

    $ copy settings.json.sample settings.json 
    $ vim settings.json
    
Then launch:

    $ cd ansible && ./install.sh