#!/bin/bash

if [ "$(ls -A .)" ]; then
  echo "Try to fetch update"
  if git checkout $GIT_BRANCH | grep -q 'up-to-date'; then
    echo "Source is up-to-date"
  else
    echo "Update dependencies"
    composer update
  fi
else
  echo "Try to clone source"
  chmod 400 ../$GIT_KEY && eval "$(ssh-agent -s)" && ssh-add ../$GIT_KEY && git clone -b $GIT_BRANCH $GIT_REPO .
  echo "Update dependencies"
  composer update
fi

php -S 0.0.0.0:80 -t ./public
