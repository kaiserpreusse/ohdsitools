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

1. Run the OHDSI tools stack with docker-compose.
2. Setup OMOP CDM database for WebAPI/ATLAS: The OMOP CDM database has to be configured according to [Setup OMOP CDM database for WebAPI/ATLAS](##-setup-omop-cdm-database-for-webapiatlas). The configuration has to be performed on existing OMOP CDM databases.
3. Define CDM database connection in WebAPI

### 1. Run the OHDSI tools stack with docker-compose

```
docker-compose -f compose-ohdsi_tools.yml up
```

### 2. Setup OMOP CDM database for WebAPI/ATLAS

- create two new schemas in the CDM database: `temp` and `results` (used later)
- use the following API endpoint to create an SQL script to populate the `results` schema
	- change `vocabSchema` to the schema where the vocabularies are stored
	- change `schema` and `tempSchema` only of you did not create `temp` and `results` in step one but want to use other schemas	
	- http://localhost:8080/WebAPI/ddl/results?dialect=postgresql&schema=results&vocabSchema=omop&tempSchema=temp&initConceptHierarchy=true
- use the script created above to populate the `results` schema
	- the process takes several minutes because concept hierarchies are integrated
	- make sure that indexes & constraints exist for the OMOP CDM database


### 3. Define CDM database connection in WebAPI

- store the connection to the CDM database in the `webapi.source` table of the WebAPI database
```
INSERT INTO webapi.source (source_id, source_name, source_key, source_connection, source_dialect) 
SELECT nextval('webapi.source_sequence'), 'My Cdm', 'MY_CDM', ' jdbc:postgresql://hostname:5432/omop_schema?user=SomeUser&password=SomeSecret', 'postgresql';

INSERT INTO webapi.source_daimon (source_daimon_id, source_id, daimon_type, table_qualifier, priority) 
SELECT nextval('webapi.source_daimon_sequence'), source_id, 0, 'omop', 0
FROM webapi.source
WHERE source_key = 'MY_CDM';
```

- refresh the sources in the WebAPI
	- http://localhost:8080/WebAPI/source/refresh
