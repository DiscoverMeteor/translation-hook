#!/bin/bash -

REPO="https://"$GITHUB_USERNAME":"$GITHUB_PASSWORD"@github.com/discovermeteor/discovermeteorstatic.git";

echo "Updating the "$LANG" translation to commit "$COMMIT" automatically.."

git clone $REPO src
cd src
git pull
git submodule init source/chapters/$LANG
git submodule update
cd source/chapters/$LANG
git checkout $COMMIT
cd ../../..
git add source/chapters/$LANG
git commit --author="Discover Meteor Machine <machine@discovermeteor.com>" \
  --message "updated $LANG submodule to $COMMIT via hook"
git push origin master
