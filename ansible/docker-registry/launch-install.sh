#!/usr/bin/env bash

ansible-playbook --ask-become-pass -i inventory.cfg install.yml
