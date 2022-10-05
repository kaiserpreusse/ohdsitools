#!/bin/bash
docker buildx build --platform linux/amd64,linux/arm64 --push -t kaiserpreusse/ohdsitools_atlas:latest atlas
docker buildx build --platform linux/amd64,linux/arm64 --push -t kaiserpreusse/ohdsitools_webapi:latest webapi
docker buildx build --platform linux/amd64,linux/arm64 --push -t kaiserpreusse/ohdsitools_webapi_database:latest webapi_database
