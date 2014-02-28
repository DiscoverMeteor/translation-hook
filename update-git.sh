#!/bin/bash -

REPO='https://github.com/discovermeteor/discovermeteorstatic.git';

git clone $REPO src
cd src
git pull
git submodule init source/chapters/$LANG
git submodule update
cd source/chapters/$LANG
git checkout $COMMIT
cd ../../..
git add source/chapters/$LANG
git commit -m "updated $LANG submodule via hook"
git push
