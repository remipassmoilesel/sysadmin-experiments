FROM node:8.5.0-alpine

RUN mkdir /server
COPY index.js /server


       # http service   # health check    # kill
EXPOSE  80              8888              9999

# use node in order to receive process events directly (SIGTERM, etc ...)
CMD node /server/index.js

