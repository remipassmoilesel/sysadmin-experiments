FROM alpine:latest
MAINTAINER remipassmoilesel
LABEL name="ansible-node"

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories \
	&& apk update \
	&& apk add openssh python shadow sudo \
	&& ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
	&& mkdir -p /var/run/sshd \
	&& sed -i -E 's/# %sudo.+/%sudo ALL=(ALL) ALL/g' /etc/sudoers \
	&& groupadd sudo \
	&& useradd -G sudo --create-home --shell /bin/sh ansible \
	&& echo ansible:ansible | chpasswd \
	&& mkdir -p /home/ansible/.ssh \
	&& chown -R ansible:ansible /home/ansible

ENTRYPOINT ["/usr/sbin/sshd", "-D"]


