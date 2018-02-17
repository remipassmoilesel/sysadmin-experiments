#!/usr/bin/env sh

if [[ -z "$@" ]]; then
    echo "You must specify IP adress of destination."
    exit 1
fi

ssh-copy-id -i /root/.ssh/id_rsa ansible@$@

if [[ "$?" -ne "0" ]]; then
    echo
    echo "***** Error while sending keys to target."
    echo
    exit $?
fi

echo
echo "***** Trying to connect via SSH without password"
echo

ssh ansible@$@