# Changer d'utilisateur dans un Dockerfile

    USER root
    RUN echo Current user: $(id -u -n)
    RUN echo 'root:azerty' | chpasswd
    RUN yum install -y epel-release
    RUN yum install -y tree net-tools
    USER jboss
