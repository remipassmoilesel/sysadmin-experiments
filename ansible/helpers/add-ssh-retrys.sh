#!/usr/bin/env bash

# Script used for dev purposes only, be careful

# Connect with: ssh -o PubkeyAuthentication=no root@10.0.2.40

echo -e "\n\nMaxAuthTries 100" >> /etc/ssh/sshd_config && service ssh restart
