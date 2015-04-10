# Docker

Use Java >= 7.

Get all the modules:

    git submodule init
    git submodule update --checkout

Update:

    git submodule foreach git checkout master
    git submodule foreach git pull

Build all projects:

    mvn install -Prun-its