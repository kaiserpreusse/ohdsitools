FROM tomcat:8-jdk8-openjdk-buster

RUN apt-get update; apt-get install -y git maven;

RUN mkdir /webapi

WORKDIR /webapi

RUN git clone https://github.com/OHDSI/WebAPI.git
WORKDIR /webapi/WebAPI

RUN git checkout refs/tags/v2.10.1

RUN mkdir WebAPIConfig

COPY settings.xml /webapi/WebAPI/WebAPIConfig/settings.xml

RUN mvn clean package -DskipUnitTests -DskipITtests -s WebAPIConfig/settings.xml -P webapi-postgresql

RUN cp target/WebAPI.war /usr/local/tomcat/webapps/

COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml