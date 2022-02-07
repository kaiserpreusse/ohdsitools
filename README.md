# Atlas & WebAPI for OMOP Development

This repository contains Docker files for:
- OHDSI WebAPI with a dedicated PostgreSQL database (`webapi` and `webapi_database`)
- Atlas (`atlas`)
- A PostgreSQL with the OMOP CDM installed (`omop_database`)

The local OMOP CDM PostgreSQL database is optional.

## Quickstart

1. Run the full stack with docker-compose.
2. Optional if no existing OMOP CDM database: Load data to the OMOP CDM PostgreSQL included in the stack.
3. The OMOP CDM database has to be configured according to [Setup OMOP CDM database for WebAPI/ATLAS](##-setup-omop-cdm-database-for-webapiatlas). The configuration has to be performed on existing OMOP CDM databases and the one included in the stack in the same way.


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