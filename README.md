# Usage #

1. Use in your Dockerfile:

  ``` bash
  FROM toancong/phpup

  ENV GIT_KEY=keyOpenSSH-mygit \
      GIT_REPO=git@bitbucket.org:monokera/project-api.git \
      GIT_BRANCH=develop

  # this key for access repository
  COPY keyOpenSSH-mygit ../keyOpenSSH-mygit

  ```

2. Want to change default run? Just replace default with yours:

  ``` bash
  FROM toancong/phpup

  ENV GIT_KEY=keyOpenSSH-mygit \
      GIT_REPO=git@bitbucket.org:monokera/project-api.git \
      GIT_BRANCH=develop

  # this key for access repository
  COPY keyOpenSSH-mygit ../keyOpenSSH-mygit
  COPY run.sh ../run.sh

  ```

3. Recommendation use docker-compose like below:

  Directory Structure

  ``` bash
  project
      api
          Dockerfile
          run.sh
          keyOpenSSH-mygit
  ```

  docker-compose.yml

  ``` bash
  version: '2'
  services:

    database:
      image: mysql
      environment:
        MYSQL_ROOT_PASSWORD: root
        MYSQL_DATABASE: mydb
        MYSQL_USER: dbuser
        MYSQL_PASSWORD: 123

    api:
      build: ./api
      environment:
        DB_HOST: database
        DB_DATABASE: mydb
        DB_USERNAME: dbuser
        DB_PASSWORD: 123
        GIT_KEY: keyOpenSSH-mygit
        GIT_REPO: git@bitbucket.org:monokera/project-api.git
        GIT_BRANCH: develop
  ```
