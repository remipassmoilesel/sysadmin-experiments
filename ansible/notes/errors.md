# Erreurs courantes

Message:

    Using /etc/ansible/ansible.cfg as config file
    <10.0.2.7> ESTABLISH SSH CONNECTION FOR USER: None
    <10.0.2.7> SSH: EXEC ssh -C -q -o ControlMaster=auto -o ControlPersist=60s -o KbdInteractiveAuthentication=no -o PreferredAuthentications=gssapi-with-mic,gssapi-keyex,hostbased,publickey -o PasswordAuthentication=no -o ConnectTimeout=10 -o ControlPath=/home/remipassmoilesel/.ansible/cp/ansible-ssh-%h-%p-%r -tt 10.0.2.7 '( umask 22 && mkdir -p "$( echo $HOME/.ansible/tmp/ansible-tmp-1502709962.68-220135603183516 )" && echo "$( echo $HOME/.ansible/tmp/ansible-tmp-1502709962.68-220135603183516 )" )'
    10.0.2.7 | UNREACHABLE! => {
        "changed": false, 
        "msg": "ERROR! SSH encountered an unknown error during the connection. We recommend you re-run the command using -vvvv, which will enable SSH debugging output to help diagnose the issue", 
        "unreachable": true
    }

Solution:

    $ vim /etc/ansibles/hosts
    
    [kubernetesSingleMaster]
    10.0.2.7 ansible_user=root

En utilisant Systemd, message:

    ERROR! no action detected in task
    
    - name: "Enable and start nats.service"
      ^ here

Solution: utiliser une version plus récente de ansible


**Message: ERROR! no action detected in task**

Cause: le nom du rôle est mauvais, ou le fichier "main.yaml" n'éxiste pas.         