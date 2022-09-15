FROM node:16

RUN apt-get update; apt-get install -y wget zip;

RUN mkdir /atlas
WORKDIR /atlas

RUN wget https://github.com/OHDSI/Atlas/releases/download/v2.11.1/atlas.zip

RUN unzip atlas.zip

COPY config-local.js /atlas/atlas/js/config-local.js

WORKDIR /atlas/atlas

#RUN npm run build

RUN npm install http-server -g

CMD http-server -p 3000
