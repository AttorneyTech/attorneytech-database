# Database-PostgreSQL

## Table of Contents

* [Run PostgreSQL on localhost](#run-postgresql-on-localhost)
* [Run in docker container](##Run-in-docker-container)
* [Run with docker compose](##Run-containers-with-docker-compose)
* [Database Schema](##Database-Schema)

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
$ docker run -e POSTGRES_USER=username \
             -e POSTGRES_PASSWORD=password \
             --net=network_name \
             -d \
             postgres:14.3
```

```shell
$ docker run -p 5050:80 \
             -e PGADMIN_DEFAULT_EMAIL=email \
             -e PGADMIN_DEFAULT_PASSWORD=password \
             --net=YOUR_network_name \
             -d \
             dpage/pgadmin4
```

We set `-p` bound the localhost port to containers port, and set `--net` deploy two containers to the same network, and we want two containers run in background, so set `-d` here.

### Open pgadmin in browser

URL: `http://localhost:5050`

Enter the information we just got.

![pgAdmin-setting](images/pgAdmin-guide4.png)

## Run containers with docker compose

In order to run multiple Containers at a time, it is more convenient to use docker compose

### Create `docker-compose.yaml` file

>Here is a [sample code][docker-compose-example] depends on docker-compose version 3.7, note that may have differences among the different versions.

You can change the following parts in the example code:

1. `POSTGRES_USER` Naming the username by yourself if necessary, otherwise `postgres` will be the default name.

2. `POSTGRES_PASSWORD`
It must not be empty or undefined, you must specify to it.

3. `PGADMIN_DEFAULT_EMAIL` and `PGADMIN_DEFAULT_PASSWORD` are also have to be defined by yourself.

### Run containers

```shell
$ docker-compose up -d
```

Put the `docker-compose.yaml` file in the same folder as your project and run the command above.

At the same time, `docker-compose` will also create a network and put the container in it.

## Database Schema

![Database Schema](images/attorneytech-database-schema.jpg)

[docker-compose-example]: <docker-compose-example.yaml>

### Tables and Columns

>This database is designed for law firms in Taiwan, so from this point of view, we need the following tables and columns. In addition, some words will be marked with Traditional Chinese (hereafter referred to as Chinese) explanation. _**In addition, all the tables use `PostgreSQL identity column` creates the id column as Primary Key in `GENERATED ALWAYS AS IDENTITY` way and the data type is `INTEGER`.**_

#### `users`

Contains _**clients**_ and _**agents**_.
Store `client` or `agent` in `role` column to identify that row which one is.

| Column       | Data Type            | Description                                                    |
| :-----       | :-----               |:---                                                            |
| id           | INTEGER              | primary key                                                    |
| role         | VARCHAR(50) NOT NULL | identify clients or agents                                     |
| username     | VARCHAR(20)          | web interface username of clients or agents                    |
| password     | VARCHAR(64)          | web interface password of clients or agents. Hashed with SHA256|
| first_name   | VARCHAR(50) NOT NULL | first name                                                     |
| middle_name  | VARCHAR(50)          | middle name                                                    |
| last_name    | VARCHAR(50) NOT NULL | last name                                                      |
| email        | VARCHAR(50)          | email                                                          |
| phone | VARCHAR(50)          | phone number                                                   |
| street_name  | VARCHAR(100)         | street name and number, floor, etc                             |
| district     | VARCHAR(20)          | district name                                                  |
| city         | VARCHAR(20)          | city name                                                      |
| zip_code     | VARCHAR(10)          | zip code                                                       |

#### `opposite_clients`

In administrative event or criminal event, the opposite is not a natural person（自然人）. \
In that case, the agent is not important. \
Another reason to separate the opposites into a table is that for the law firm, \
it is necessary to pay attention to the conflict of interest（利益衝突）, the opposite is possible to become \
a client in the future. \
Therefore, it is necessary to check this before accepting a case. \
In addition, because it's usually don't know the email and phone number of the opposite, \
it's only need to know the papers sending address, so the columns for email and phone number \
would not added in this table.

| Column       | Data Type            | Description                                           |
| :---         | :----                | :---                                                  |
| id           | INTEGER              | primary key                         |
| name         | VARCHAR(100)         | name of administration（行政機關） or prosecutor（檢察官）|
| first_name   | VARCHAR(50) NOT NULL | first name                                            |
| middle_name  | VARCHAR(50)          | middle name                                           |
| last_name    | VARCHAR(50) NOT NULL | last name                                             |
| street_name  | VARCHAR(100)         | street name and number, floor, etc                    |
| district     | VARCHAR(20)          | district name                                         |
| city         | VARCHAR(20)          | city name                                             |
| zip_code     | VARCHAR(10)          | zip code                                              |

#### `opposite_agents`

| Column       | Data Type            | Description                         |
| :---         | :----                | :---                                |
| id           | INTEGER              | primary key                         |
| first_name   | VARCHAR(50) NOT NULL | first name                          |
| middle_name  | VARCHAR(50)          | middle name                         |
| last_name    | VARCHAR(50) NOT NULL | last name                           |
| email        | VARCHAR(50)          | email                               |
| phone | VARCHAR(50)          | phone number                        |
| street_name  | VARCHAR(100)         | street name and number, floor, etc  |
| district     | VARCHAR(20)          | district name                       |
| city         | VARCHAR(20)          | city name                           |
| zip_code     | VARCHAR(10)          | zip code                            |

#### `papers`

Contains _**paper_sent**_ and _**paper_received**_.
Enter `paper_sent` or `paper_received` in `category` column to identify that row which one is.

| Column        | Data Type                   | Description                                           |
| :---          | :----                       | :---                                                  |
| id            | INTEGER                     | primary key                                           |
| category      | VARCHAR(50)  NOT NULL       | identify paper sent or received                       |
| title         | VARCHAR(100) NOT NULL       | the paper's title like “民事答辯狀”, “刑事辯護狀”        |
| subject       | VARCHAR(400) NOT NULL       | subject of papers                                     |
| sent_date     | DATE                        | sent date of papers                                   |
| arrival_date  | DATE                        | papers we send and it's arrival date                  |
| received_date | DATE                        | papers from opposite that when we received                 |
| deadline_date | DATE                        | if papers we received has something need to do        |
| court_date    | TIMESTAMP| next court date and time                              |
| paper_type    | VARCHAR(50) NOT NULL        | like “起訴狀”, “答辯狀”                           |
| case_id       | INTEGER NOT NULL            | foreign key to cases table                            |
| paper_file_id | INTEGER NOT NULL            | foreign key to paper_file table                     |

#### `paper_files`

Paper's files

| Column | Data Type                    | Description                           |
| :---   | :----                        | :---                                  |
| id     | INTEGER                      | primary key                           |
| name   | VARCHAR(100) UNIQUE NOT NULL | paper file name                       |
| file   | bytea                        | paper file, store in bytea data type. |

#### `section_in_charges`

Section in charge, which means “股別” in Chinese. In Taiwan's legal system, each case will be distributed to specific section in charge, it's important because when attorney want to contact court, he must go through section in charge.

| Column            | Data Type        | Description                  |
| :---              | :----            | :---                         |
| id                | INTEGER          | primary key                  |
| name              | VARCHAR(20)      | name of section in charge    |
| clerk_first_name  | VARCHAR(50)      | contact person's first name  |
| clerk_last_name   | VARCHAR(50)      | contact person's last name   |
| extension_number  | VARCHAR(50)      | extension number             |
| court_id          | INTEGER NOT NULL | foreign key to courts table  |

#### `courts`

As mentioned above, and so on in the `case` mentioned below, build court into a table in order to associate `section_in_charge` and `case`.

| Column       | Data Type                    | Description                        |
| :---         | :----                        | :---                               |
| id           | INTEGER                      | primary key                        |
| name         | VARCHAR(100) UNIQUE NOT NULL | name of court                      |
| phone | VARCHAR(50) NOT NULL         | phone number of court              |
| street_name  | VARCHAR(100)                 | street name and number, floor, etc |
| district     | VARCHAR(20)                  | district name                      |
| city         | VARCHAR(20)                  | city name                          |
| zip_code     | VARCHAR(10)                  | zip code                           |

#### `events`

An event is a collection of many cases, an event may walk through many instance levels of court（審級）, \
and in each instance level of court will have different case number. \
So it's necessary to separate the events into a table.

| Column             | Data Type                    | Description                           |
| :---               | :----                        | :---                                  |
| id                 | INTEGER                      | primary key                           |
| name               | VARCHAR(100) UNIQUE NOT NULL | event name like “甲與乙台北市東興路房地拆屋還地事件”, “丙被訴違反證券交易法事件”, “丁與台北市政府確認文山區土地公用地役關係存在事件”                    |
| client_id          | INTEGER NOT NULL            | foreign key to users table.            |
| opposite_client_id | INTEGER NOT NULL            | foreign key to opposite_clients table. |

#### `cases`

Basically, in a law firm, it can be said that it operates by handling cases. Creating a table of case help us to associate with other tables.

| Column                | Data Type            | Description                                     |
| :---                  | :----                | :---                                            |
| id                    | INTEGER              | primary key                                     |
| category              | VARCHAR(20) NOT NULL | means “案件類別” in Chinese like “民事” or “刑事” |
| year                  | VARCHAR(20)      | The year of the case, Taiwan's legal system is mainly calculated from the years of the Republic of China. For example, 2022 year is equal to 111 year in Taiwan.  |
| type                  | VARCHAR(50)          | means “案號字別” in Chinese. For example, like “訴”, “上”, “重訴”, “勞訴”, etc.                                                                                             |
| number                | VARCHAR(10)          | number of cases                                 |
| cause_of_action       | VARCHAR(100)              | which means “案由” in Chinese like “拆屋還地”          |
| event_id              |INTEGER NOT NULL      | foreign key, mark the same case in whole lawsuit procedure to one event  |
| section_in_charges_id | INTEGER              | foreign key to section in charges table |
| court_id             | INTEGER              | foreign key to courts table             |
| client_id             | INTEGER NOT NULL     | foreign key to users table              |
| agent_id              | INTEGER NOT NULL     | foreign key to users table              |
| opposite_client_id    | INTEGER              | foreign key to opposite_clients table   |
| opposite_agent_id     | INTEGER              | foreign key to opposite_agent table     |
