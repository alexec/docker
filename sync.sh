#! /bin/sh
set -eux

git pull
git submodule foreach git checkout master
git submodule foreach git pull
git submodule foreach git push
git commit -a -m 'master'
git push

