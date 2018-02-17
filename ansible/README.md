# Ansible experiments

Small Docker images that can be used to experiment various things with Ansible.

Based on Alpine Linux (very light images).

## Roles

All roles are placed in `roles/` directory.

## Usage

Clone repository:

	$ cd /tmp
	$ git clone https://github.com/remipassmoilesel/ansible-experiments
	$ cd ansible-experiments
	$ git submodule init
	$ git submodule update

Launch one or several nodes:

	$ docker build -t ansible-node node.docker
	$ docker run -d ansible-node

Launch one interactive master:

	$ docker build -t ansible-master master.docker
	$ docker run -ti ansible-master

Show all IP address of containers:

	$ ./display-ip-adresses.sh

From master, send keys to nodes (pwd: ansible)

	$ ssh-copy-id -i /root/.ssh/id_rsa ansible@172.17.0.3 

Populate host file:

	$ vim /etc/ansible/hosts
	
	[groupname]
	172.17.0.2
	172.17.0.3
	
From master, test:

	$ ansible -m ping all --one-line -u ansible

Some helpers are available in master container at `/root/` location.