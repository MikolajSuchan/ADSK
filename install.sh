#!/bin/bash

##Configuration

REPOSITORY=https://github.com/MikolajSuchan/computer-programming-4-2024.git
TMP_DESTINATION=/tmp/ecommerce
VERSION=main

APP_USERNAME=ecommerce
APP_DESTINATION=/opt/ecommerce


##Install base OS dependencies
dnf install -y -q cowsay tree mc 

##Git and Repository
dnf install -y git

rm -rf ${TMP_DESTINATION} || true

git clone ${REPOSITORY} -b ${VERSION} ${TMP_DESTINATION}

##Java Runtime

dnf install -y -q java-17-amazon-corretto maven-local-amazon-corretto17

##Create dir & user
adduser ${APP_USERNAME}
mkdir -p ${APP_DESTINATION}

##Compile && Package
cd ${TMP_DESTINATION} && mvn -DskipTests package
mv ${TMP_DESTINATION}/target/*.jar ${APP_DESTINATION}/app.jar
chown -R ${APP_USERNAME}:${APP_USERNAME} ${APP_DESTINATION}

echo "java -jar -Dserver.port=8080 /opt/ecommerce/app.jar"

rm -rf ${TMP_DESTINATION}





echo "OK"