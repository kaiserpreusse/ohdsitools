
## Athena vocabularies

### prepare vocabulary files
- aus Lizenzgründen muss ein Vocabulary separat runtergeladen werden, es kann nicht mit den anderen zusammen runtergeladen werden
- in dem Vocabulary package ist eine Anleitung: `readme.txt`
- das tool zum runterladen braucht Java

```
sudo apt-get install default-jre
```

- das Tool braucht eine UMLS API key

- Erklärung aus der `readme.txt`

```
CPT4 utility for CDM v5.

This utility will import the CPT4 vocabulary into concept.csv.
Internet connection is required.

Start import process from command line with:
 windows: cpt.bat APIKEY
 linux: ./cpt.sh APIKEY

Use API KEY from UMLS account profile: https://uts.nlm.nih.gov//uts.html#profile
Do not close or shutdown your PC until the end of import process,
it will cause damage to concept.csv file.

Please make sure java allowed to make http requests and has write permission to the concept.csv file.
```



# Archive: server setup
## Distribution herausfinden

```
cat /etc/*release*
```

Ubuntu 20.04


## Tools installieren
- tmux
```
sudo apt install tmux
```

## Docker installieren
https://docs.docker.com/engine/install/ubuntu/

### install dependencies, set up repo

```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
```

### install and set up Docker

```
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### post installation steps

```
sudo groupadd docker

sudo usermod -aG docker mpreusse
```

##  docker-compose installieren

```
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
```

# prepare OMOP database
## run Postgres
...

## create and load schema
- https://github.com/OHDSI/CommonDataModel/tree/master/PostgreSQL
- branch v5.3.1_fixes

### use DDL to create tables
- Execute the script OMOP CDM postgresql v5_3_1 ddl.sql to create the tables and fields.

### create primary keys
- Execute the script OMOP CDM postgresql v5_3_1 primary keys.sql to add the primary key constraints.

