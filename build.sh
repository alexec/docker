#! /bin/sh
set -eux

# mvn clean
# mvn install -DskipTests
# mvn versions:use-latest-releases -rf :docker-java-orchestration -Dincludes='com.alexecollins*'
mvn install -Prun-its

cd docker-gradle-pluin
gradle build
