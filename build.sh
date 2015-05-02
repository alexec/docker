#! /bin/sh
set -eux

for CMD in $* ; do
    case "$CMD" in
        analyse|analyze)
            cd docker-java-orchestration
            mvn install org.pitest:pitest-maven:mutationCoverage -D targetClasses='com.alexecollins.*'
            ;;
        init)
            git submodule init
            git submodule update --checkout
            ;;
        pull)
            git pull
            git submodule foreach git checkout master
            git submodule foreach git pull
            ;;
        clean)
            find . -name pom.xml.versionsBackup | xargs rm -v
            mvn clean
            cd docker-gradle-plugin
            gradle clean
            cd -
            ;;
        build)
            docker ps -q | xargs docker kill

            # seems to fail tests
            cd docker-java
            mvn install -DskipTests
            cd -

            mvn -U install -Prun-its -rf :docker-java-orchestration

            cd docker-gradle-pluin
            gradle buildLoc
            cd -
            ;;
        commit)
            git add $(find . -mindepth 1 -maxdepth 1 -type d ! -path './.*')
            git commit -m 'master'
            ;;
        push)
            git submodule foreach git push
            git push
            ;;
        release)
		unset JAVA_HOME
            cd docker-java-orchestration
		git reset --hard origin/master
		git clean -fd
            mvn release:prepare release:perform -B
            cd -

            cd docker-maven-plugin
		git reset --hard origin/master
		git clean -fd
            mvn versions:use-latest-versions -Dincludes='com.alexecollins.docker:*'
            git add pom.xml
            git commit -m 'use latest versions'
            mvn release:prepare release:perform -B
            mvn -U versions:unlock-snapshots -Dincludes='com.alexecollins.docker:*'
            cd -
            ;;
        update-versions)
            mvn versions:use-latest-versions -DexcludeReactor=false -DallowSnapshots -Dincludes='com.github.docker-java:*,com.alexecollins.docker:*'

            find . -name pom.xml.versionsBackup | xargs rm -v

            # TODO - update Gradle
            
            git status
            ;;
        *)
            echo "unknown command '$CMD', try init clean build pull push commit update-versions" > /dev/stderr
            exit 1
    esac
done
