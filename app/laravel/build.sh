#!/bin/bash

chmod 400 ../$GIT_KEY && eval "$(ssh-agent -s)" && ssh-add ../$GIT_KEY

if [ "$(ls -A .)" ]; then
  echo "Try to fetch update"
  git checkout $GIT_BRANCH
  if git pull | grep -q 'up-to-date'; then
    echo "Source is up-to-date"
  else
    echo "Update dependencies"
    composer update
  fi
else
  echo "Try to clone source"
  git clone -b $GIT_BRANCH $GIT_REPO .
  echo "Install dependencies"
  composer install
  composer install
fi

php artisan migrate --force

echo "Done build!"
