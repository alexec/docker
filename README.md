# Docker

Use Java >= 7.

Get all the modules:

    git submodule init
    git submodule update --checkout

Update:

    git pull
    git submodule foreach git checkout master
    git submodule foreach git pull
    git commit -a -m 'master'

Build all projects:

    mvn install -Prun-its