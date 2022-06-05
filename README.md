# Database-PostgreSQL

## Table of Contents

* [Run PostgreSQL on localhost](#run-postgresql-on-localhost)
* [PostgreSQL via pgAdmin](##Connect-PostgreSQL-via-pgAdmin)
* [Run in docker container](##Run-in-docker-container)
* [Run with docker compose](##Run-containers-with-docker-compose)

## Run PostgreSQL on localhost

### Downloading PostgreSQL from homebrew

```shell
$ brew install postgresql
```

### Start PostgreSQL service

```shell
$ brew services start postgresql
```

### Creating a Database

```shell
$ createdb database_name
```

If this produces no response then this step was successful

You can then connect to the database with:

```shell
$ psql database_name
```

## Connect PostgreSQL via pgAdmin

Open pgAdmin and right click on Server

![Click on server](images/pgAdmin-guide1.png)

Enter a name, hostname, port 5432 (default), database name and username.

![Enter a name](images/pgAdmin-guide2.png)

![Enter host name](images/pgAdmin-guide3.png)

## Run in docker container

### Download docker form brew

```shell
$ brew install --cask docker
```

Because docker is a system-level package, you cannot install it using brew install, and must use `--cask` instead.

Then launch the docker app. Click next. It will ask for privileged access. Confirm.

A whale icon should appear in the top bar. Click it and wait for "Docker is running" to appear.

### Pull the image

```shell
$ docker pull postgres:14.3
```

```shell
$ docker pull dpage/pgadmin4
```

If not add tag, it will pull the latest version of image

### Create and run container

There are many option parameters you can choose by yourself

And here we're going to set：

```shell
$ docker run -e POSTGRES_USER=your_name \
             -e POSTGRES_PASSWORD=YOUR_PASSWORD
             --net=YOUR_NETWORK_NAME \
             -d \
             postgres:14.3 \   
```

```shell
$ docker run -p 5050:80 \
             -e PGADMIN_DEFAULT_EMAIL=YOUR_EMAIL \
             -e PGADMIN_DEFAULT_PASSWORD=YOUR_PASSWORD \
             --net=YOUR_NETWORK_NAME \
             -d \
             dpage/pgadmin4 \
```

We set `-p` bound the localhost port to containers port, and set `--net` deploy two containers to the same network, and we want two containers run in background, so set `-d` here.

### Open pgadmin in browser

URL: `http://localhost:5050`

Enter the information we just got.

![pgAdmin-setting](images/pgAdmin-guide4.png)

## Run containers with docker compose

In order to run multiple Containers at a time, it is more convenient to use docker compose

### Create `docker-compose.yaml` file

```yaml
version: "3.7"
services:
  db:
    image: postgres:14.3
    restart: always
    environment:
      POSTGRES_USER: YOUR_USER_NAME
      POSTGRES_PASSWORD: YOUR_PASSWORD
    volumes:
      - DB_VOLUME_NAME:/var/lib/postgresql/data
  pgadmin:
    depends_on:
      - db
    image: dpage/pgadmin4
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: YOUR_EMAIL
      PGADMIN_DEFAULT_PASSWORD: YOUR_PASSWORD
    ports:
      - "5050:80"
    volumes:
      - PG_VOLUME_NAME:/var/lib/pgadmin
volumes:
  DB_VOLUME_NAME:
  PG_VOLUME_NAME:
```

>This is the sample depends on docker-compose version 3.7, note that may have differences among the different versions.

1. `POSTGRES_USER` Naming the username by yourself if necessary, otherwise `postgres` will be the default name.

2. `POSTGRES_PASSWORD`
It must not be empty or undefined, you must specify to it.

3. `PGADMIN_DEFAULT_EMAIL` and `PGADMIN_DEFAULT_PASSWORD` are also have to be defined by yourself.

4. `volumes` Naming the volumes name by yourself.

### Run containers

```shell
$ docker-compose up -d
```

Put the `docker-compose.yaml` file in the same folder as your project and run the command above.

At the same time, `docker-compose` will also create a network and put the container in it.
