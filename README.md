# Database-PostgreSQL

## Table of Contents

* [Run PostgreSQL on localhost](#run-postgresql-on-localhost)
* [PostgreSQL via pgAdmin](##Connect-PostgreSQL-via-pgAdmin)
* [Run in docker container](##Run-in-docker-container)
* [Run with docker compose](##Run-with-docker-compose)

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
$ createdb <dbname>
```

If this produces no response then this step was successful

You can then connect to the database with:

```shell
$ psql -h [hostname] -p [port] [dbname] [username]
```

## Connect PostgreSQL via pgAdmin

Open pgAdmin and right click on Server

![Click on server](attorneytech-database/images/pgAdmin-guide1.png)

Enter a name, hostname, port 5432(default), database name and username.

![Enter a name](attorneytech-database/images/pgAdmin-guide2.png)

![Enter host name](attorneytech-database/images/pgAdmin-guide3.png)

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
$ docker run -p 5432:5432 \
             -e POSTGRES USER=postgres \
             -e POSTGRES PASSWORD=password
             --net=postgres \
             -d postgres:14.3
```

```shell
$ docker run -p 5050:80 \
             -e PGADMIN DEFAULT EMAIL=user@domain.com \
             -e PGADMIN_DEFAULT_PASSWORD=password
             --net=postgres \
             -d dpage/pgadmin4
```

We set`-p` bound the localhost port to containers port, and set `--net` deploy two containers to the same network.And we want two containers run in background, so set `-d` here.

And if you want to enter the CLI in postgre:

```shell
$ docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```

### Get the IP address of postgres

```shell
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name>
```

When Docker creates a container, it will randomly select an address for the container to use within the private network range defined in RFC 1918, which is also commonly known as the same network segment.

Using this bridge, the container can communicate with the host system and other containers.

* [瞭解 Docker 的預設網路設置][link1]

Alternativly, you can get the IP by checking the network that we just set above `docker network inspect`.

```shell
$ docker network inspect postgres
```

![network-container](attorneytech-database/images/network-container.png)

### Open pgadmin in browser

URL: `http://localhost:5050`

Enter the information we just got.

![pgAdmin-setting](attorneytech-database/images/pgAdmin-guide4.png)

## Run containers with docker compose

In order to run multiple Containers at a time, it is more convenient to use docker compose

### Create `.yaml` file

```yaml
version: "3.7"
services:
  db:
    image: postgres:14.3
    restart: always
    environment:
      POSTGRES_DB: postgres
      POSTGRES_USER: YOUR_USER_NAME
      POSTGRES_PASSWORD: YOUR_PASSWORD
      PGDATA: /var/lib/postgresql/data
    volumes:
      - db-data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
  pgadmin:
    image: dpage/pgadmin4
    restart: always
    environment:
      PGADMIN_DEFAULT_EMAIL: YOUR_EMAIL
      PGADMIN_DEFAULT_PASSWORD: YOUR_PASSWORD
      PGADMIN_LISTEN_PORT: 80
    ports:
      - "5050:80"
    volumes:
      - pgadmin-data:/var/lib/pgadmin
volumes:
  db-data:
  pgadmin-data:
```

### Run containers

```shell
$ docker-compose -f docker-compose.yaml up -d
```

Put the `.yaml` file in the same folder as your project and run the command above.

At the same time, `docker-compose` will also create a network and put the container in it.

So we can check the IP of postgres in the [same way](###Get-the-IP-address-of-postgres).

[link1]: https://mileslin.github.io/2019/05/%E7%9E%AD%E8%A7%A3-Docker-%E7%9A%84%E9%A0%90%E8%A8%AD%E7%B6%B2%E8%B7%AF%E8%A8%AD%E7%BD%AE/ "瞭解 Docker 的預設網路設置"
