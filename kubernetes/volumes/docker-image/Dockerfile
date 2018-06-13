FROM node:9-alpine

RUN mkdir -p /server
RUN mkdir -p /container-dir
RUN mkdir -p /host-path-example

COPY template.html /server
COPY main.js /server

CMD ["node", "/server/main.js"]