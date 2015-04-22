#! /bin/sh
set -eux

git pull
git submodule foreach git checkout master
git submodule foreach git pull
git commit -a -m 'master'