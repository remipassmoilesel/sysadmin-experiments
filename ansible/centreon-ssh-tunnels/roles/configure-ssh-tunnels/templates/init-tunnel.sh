#!/usr/bin/env bash

set -x

# SSH port used on the centreon central to contact poller

logger Starting autossh tunnels: ssh-tunnel.poller.{{ hostvars['centreon-poller']['ansible_host'] }}

LOCAL_SSH_PORT={{ local_poller_ssh_port }}

# Time between ssh connexion checks in second
AUTOSSH_POLL=30

# Autossh monitoring ports, ports and ports + 1 must be free
AUTOSSH_MPORT_LOCAL={{ local_poller_ssh_port + 100}}
AUTOSSH_MPORT_REMOTE={{ local_poller_ssh_port + 103}}

# Publish a remote port to allow poller to contact central
autossh -f -N -M $AUTOSSH_MPORT_LOCAL -R 6669:localhost:5669 ssh-tunnel.poller.{{ hostvars['centreon-poller']['ansible_host'] }}

logger Remote port tunnel: $?

# Publish a local port to allow central to contact poller
autossh -f -N -M $AUTOSSH_MPORT_REMOTE -L $LOCAL_SSH_PORT:localhost:22 ssh-tunnel.poller.{{ hostvars['centreon-poller']['ansible_host'] }}

logger Local port tunnel: $?
