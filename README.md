# Atlas & WebAPI for OMOP Development

> ⚠️ Versions, usernames, database names, and other paramters are not configurable yet.

## Components

- WebAPI running in Tomcat (`webapi`)
    - https://github.com/OHDSI/WebAPI
- Postgres database for the WebAPI (`webapi_database`)
    - setup described here: https://github.com/OHDSI/WebAPI/wiki/PostgreSQL-Installation-Guide
    - the `setup_webapi_db.sh` script creates the schema and users
- Atlas (`atlas`)

## Quickstart

1. Run the full stack with docker-compose.
2. The OMOP CDM database has to be configured according to [Setup OMOP CDM database for WebAPI/ATLAS](##-setup-omop-cdm-database-for-webapiatlas). The configuration has to be performed on existing OMOP CDM databases and the one included in the stack in the same way.


## Setup OMOP CDM database for WebAPI/ATLAS

### 1. Create temp/results schema in CDM data source
- create temp and results schema in the CDM data source
- get the result schema and run on the CDM data source
	- http://localhost:8080/WebAPI/ddl/results?dialect=postgresql&schema=results&vocabSchema=omop&tempSchema=temp&initConceptHierarchy=true

- http://localhost:8080/WebAPI/source/refresh


### 2. define CDM data source in WebAPI


INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect) 
SELECT nextval('webapi.source_sequence'), 'My Cdm', 'MY_CDM', ' jdbc:postgresql://host.docker.internal:5432/omop?user=postgres&password=testme', 'postgresql';


INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) 
SELECT nextval('webapi.source_daimon_sequence'), source_id, 0, 'omop', 0
FROM webapi.source
WHERE source_key = 'MY_CDM'
;

INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) 
SELECT nextval('webapi.source_daimon_sequence'), source_id, 1, 'omop', 1
FROM webapi.source
WHERE source_key = 'MY_CDM'
;

INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) 
SELECT nextval('webapi.source_daimon_sequence'), source_id, 2, 'results', 1
FROM webapi.source
WHERE source_key = 'MY_CDM'
;

INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) 
SELECT nextval('webapi.source_daimon_sequence'), source_id, 5, 'temp', 0
FROM webapi.source
WHERE source_key = 'MY_CDM'