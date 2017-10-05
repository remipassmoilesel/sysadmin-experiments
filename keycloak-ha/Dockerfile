FROM jboss/keycloak-ha-postgres:3.2.1.Final

# install helpers
USER root
RUN echo Current user: $(id -u -n)
RUN echo 'root:azerty' | chpasswd
RUN yum install -y epel-release
RUN yum install -y tree net-tools vim
USER jboss
# end install helpers