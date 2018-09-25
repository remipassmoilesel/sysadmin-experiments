FROM alpine:3.2

RUN apk update && apk add bind bind-tools

COPY named.conf /etc/bind/named.conf

EXPOSE 53/udp

CMD /usr/sbin/named -f -c /etc/bind/named.conf