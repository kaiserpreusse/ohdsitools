FROM node:16

RUN apt-get update; apt-get install -y wget zip;

RUN mkdir /atlas
WORKDIR /atlas
RUN wget https://github.com/OHDSI/Atlas/archive/refs/tags/v2.11.1.zip

RUN unzip v2.11.1.zip

COPY config-local.js /atlas/Atlas-2.11.1/js/config-local.js

WORKDIR /atlas/Atlas-2.11.1

RUN npm run build

RUN npm install http-server -g

CMD http-server -p 3000
