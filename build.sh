#! /bin/sh
set -eux

for CMD in $* ; do
    case "$CMD" in
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
            mvn clean
            cd docker-gradle-plugin
            gradle clean
            ;;
        build)
            mvn -U install -Prun-its -rf :docker-java-orchestration

            cd docker-gradle-pluin
            gradle build
            ;;
        commit)
            MESSAGE=${2:-'master'}

            git submodule foreach git commit -m $MESSAGE
            ;;
        push)
            git submodule foreach git push
            git push
            ;;
        update-versions)
            mvn -U versions:lock-snapshots \
                versions:use-latest-releases -Dincludes='com.github.docker-java:*,com.alexecollins.docker:*'

            find . -name pom.xml.versionsBackup | xargs rm -v

            # TODO - update Gradle
            ;;
        *)
            echo "unknown command '$CMD', try init clean build pull push commit update-versions" > /dev/stderr
            exit 1
    esac
done