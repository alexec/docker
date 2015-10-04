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
            find . -name pom.xml.versionsBackup | xargs rm -v
            mvn clean
            cd docker-gradle-plugin
            gradle clean
            cd -
            ;;
        build)
            docker ps -q | xargs docker kill

            mvn -U install -Prun-its

            cd docker-gradle-pluin
            gradle buildLoc
            cd -
            ;;
        push)
            git submodule foreach git push
            git push
            ;;
        update-versions)
            mvn versions:use-latest-versions -DexcludeReactor=false -DallowSnapshots -Dincludes='com.alexecollins.docker:*' -DgenerateBackupPoms=false
            ;;
        release)
            ansible-playbook -i inventory release-docker-java-orchestration.yml release-docker-maven-plugin.yml
            ;;
        *)
            echo "unknown command '$CMD', try init clean build pull push commit update-versions" > /dev/stderr
            exit 1
    esac
done
