#! /bin/sh
set -eux

mvn install -DskipTests
mvn versions:use-latest-releases -rf :docker-java-orchestrator
mvn install -Prun-its

cd docker-gradle-pluin
gradle build
