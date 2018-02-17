FROM alpine:latest

MAINTAINER remipassmoilesel
LABEL name="ansible-master"

COPY helpers /root/
RUN chmod +x /root/*.sh

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories \
	&& apk update \
	&& apk add vim \
	&& apk add ansible@testing \
	&& mkdir -p /etc/ansible \
	&& touch /etc/ansible/ansible.cfg \
	&& touch /etc/ansible/hosts \
	&& apk add openssh \
	&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
	&& ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
	&& ssh-keygen -f /root/.ssh/id_rsa -N '' -t rsa \
	&& ssh-keygen -f /root/.ssh/id_dsa -N '' -t dsa \
	&& mkdir -p /var/run/sshd

