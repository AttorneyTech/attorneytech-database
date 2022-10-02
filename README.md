# Database-PostgreSQL

[中文版本（Chinese Version）](./README%20(Chinese).md)

## Table of Contents

* [Run PostgreSQL on localhost](#run-postgresql-on-localhost)
* [Run in docker container](#run-in-docker-container)
* [Run with docker compose](#run-containers-with-docker-compose)
* [Database Schema](#database-schema)

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

If not add tag (e.g. `postgres:14.3`), it will pull the latest version of image

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

![Database Schema](attorneytech-database-schema.png)

[docker-compose-example]: <docker-compose-example.yaml>

### Tables and Columns

>This database is designed for law firms in Taiwan, so from this point of view, we need the following tables and columns.
>In addition, some words will be marked with Traditional Chinese (hereafter referred to as Chinese) explanation.
>_**All the tables use `PostgreSQL identity column` creates the id column as Primary Key in `GENERATED ALWAYS AS IDENTITY` way and the data type is `INTEGER`.**_

#### `users`

Contains _**clients**_ and _**agents**_.
Store `client` or `agent` in `role` column to identify that row which one is.

| Column       | Data Type                   | Description                                                    |
| :-----       | :-----                      |:---                                                            |
| id           | INTEGER                     | An unique ID of user                                           |
| role         | VARCHAR(50) NOT NULL        | Identify clients or agents                                     |
| username     | VARCHAR(20) UNIQUE          | Username of user                                               |
| password     | VARCHAR(64)                 | Password of user                                               |
| first_name   | VARCHAR(50) NOT NULL        | First name of user                                             |
| middle_name  | VARCHAR(50)                 | Middle name of user                                            |
| last_name    | VARCHAR(50) NOT NULL        | Last name of user                                              |
| email        | VARCHAR(50) UNIQUE NOT NULL | Email of user                                                  |
| phone        | VARCHAR(50)                 | Phone number of user                                           |
| street_name  | VARCHAR(100)                | The part of the user's address below the street name           |
| district     | VARCHAR(20)                 | The district name of user's address                            |
| city         | VARCHAR(20)                 | The city name of user's address                                |
| zip_code     | VARCHAR(10)                 | The zip code of user's address                                 |

#### `opposites`

Contains _**party**_ and _**agents**_.
Store `party` or `agent` in `role` column to identify that row which one is.
In administrative event or criminal event, the opposite is not a natural person（自然人）. \
So in this case, we store the name into organization_name column. \

| Column            | Data Type            | Description                                              |
| :---              | :----                | :---                                                     |
| id                | INTEGER              | An unique ID of opposite                                 |
| role              | VARCHAR(50) NOT NULL | Identify the opposite is party or agent                  |
| organization_name | VARCHAR(100)         | The name of organization                                 |
| first_name        | VARCHAR(50)          | First name of opposite                                   |
| middle_name       | VARCHAR(50)          | Middle name of opposite                                  |
| last_name         | VARCHAR(50)          | Last name of opposite                                    |
| email             | VARCHAR(50)          | Email of opposite                                        |
| phone             | VARCHAR(50)          | Phone number of opposite                                 |
| street_name       | VARCHAR(100)         | The part of the opposite's address below the street name |
| district          | VARCHAR(20)          | The district name of opposite's address                  |
| city              | VARCHAR(20)          | The city name of opposite's address                      |
| zip_code          | VARCHAR(10)          | The city name of opposite's address                      |

#### `courts`

As mentioned above, and so on in the `case` mentioned below, build court into a table in order to associate `section_in_charge` and `case`.

| Column       | Data Type                    | Description                                           |
| :---         | :----                        | :---                                                  |
| id           | INTEGER                      | An unique ID of court                               |
| name         | VARCHAR(100) UNIQUE NOT NULL | Name of court                                         |
| phone        | VARCHAR(50) NOT NULL         | Phone number of court                                 |
| street_name  | VARCHAR(100)                 | The part of the court's address below the street name |
| district     | VARCHAR(20)                  | The district name of court's address                  |
| city         | VARCHAR(20)                  | The city name of court's address                      |
| zip_code     | VARCHAR(10)                  | The zip code of court's address                       |

#### `section_in_charges`

Section in charge, which means “股別” in Chinese. In Taiwan's legal system, each case will be distributed to specific section in charge, it's important because when attorney want to contact court, he must go through section in charge.

| Column            | Data Type        | Description                                    |
| :---              | :----            | :---                                           |
| id                | INTEGER          | An unique ID of section in charge              |
| name              | VARCHAR(20) NOT NULL     | Name of section in charge                      |
| clerk_first_name  | VARCHAR(50)      | Contact person's first name                    |
| clerk_middle_name | VARCHAR(50)      | Contact person's middle name                   |
| clerk_last_name   | VARCHAR(50)      | Contact person's last name                     |
| extension_number  | VARCHAR(50)      | Section in charge's extension number           |
| court_id          | INTEGER NOT NULL | Associated court ID with the section in charge |

#### `events`

An event is a collection of many cases, an event may walk through many instance levels of court（審級）, \
and in each instance level of court will have different case number. \
So it's necessary to separate the events into a validation table.

| Column             | Data Type                    | Description                           |
| :---               | :----                        | :---                                  |
| id                 | INTEGER                      | An unique ID of event              |
| name               | VARCHAR(100) UNIQUE NOT NULL | Event name like “甲與乙台北市東興路房地拆屋還地事件”, “丙被訴違反證券交易法事件”, “丁與台北市政府確認文山區土地公用地役關係存在事件”                             |

#### `cases`

Basically, in a law firm, it can be said that it operates by handling cases. Creating a table of case help us to associate with other tables.

| Column                | Data Type            | Description                                     |
| :---                  | :----                | :---                                            |
| id                    | INTEGER              | An unique ID of case                     |
| case_closed           | boolean              | The case has been closed or not|
| category              | VARCHAR(20) NOT NULL | Means “案件類別” in Chinese like “民事” or “刑事” |
| year                  | smallint      | The year of the case, Taiwan's legal system is mainly calculated from the years of the Republic of China. For example, 2022 year is equal to 111 year in Taiwan.  |
| type                  | VARCHAR(50)          | Means “案號字別” in Chinese. For example, like “訴”, “上”, “重訴”, “勞訴”, etc.                                                                                             |
| number                | VARCHAR(20)          | Number of cases                                 |
| cause_of_action       | VARCHAR(100)              | Which means “案由” in Chinese like “拆屋還地”          |
| event_id              |INTEGER NOT NULL      | References the id column in event, marks the same case in whole lawsuit procedure to one event|
| section_in_charges_id | INTEGER              | References the id column in section_in_charge, indicates which section in charge is handling this case |
| court_id             | INTEGER              |References the id column in court, indicates which court is handling this case            |
| user_id             | INTEGER     | References the id column in user to identify which user was involved in this case              |
| opposite_id    | INTEGER              | References the id column in opposite, to identify which opposite was involved in this

#### `paper_files`

Paper's files

| Column | Data Type                    | Description                           |
| :---   | :----                        | :---                                  |
| id     | INTEGER                      | An unique ID of paper file            |
| name   | VARCHAR(100) UNIQUE NOT NULL | Name of aper file                     |
| file   | bytea NOT NULL               | Paper file, store in bytea data type. |

#### `papers`

Contains _**paper_sent**_ and _**paper_received**_.
Enter `paper_sent` or `paper_received` in `category` column to identify
that row which one is.

| Column        | Data Type                   | Description                                           |
| :---          | :----                       | :---                                                  |
| id            | INTEGER                     | An unique ID of a paper                               |
| category      | VARCHAR(50)  NOT NULL       | Identify paper sent or received                       |
| title         | VARCHAR(100) NOT NULL       | The paper's title like “民事答辯狀”, “刑事辯護狀”         |
| subject       | VARCHAR(400) NOT NULL       | Subject of paper                                      |
| sent_date     | DATE                        | Sent date of paper                                    |
| arrival_date  | DATE                        | Paper we send and it's arrival date                   |
| received_date | DATE                        | Paper from opposite that when we received             |
| deadline_date | DATE                        | If paper we received has something need to do         |
| court_date    | TIMESTAMP                   | Next court date and time                              |
| paper_type    | VARCHAR(50) NOT NULL        | Paper's type like “起訴狀”, “答辯狀”                    |
| case_id       | INTEGER NOT NULL            | Associated with case ID, to identify which case the paper is belong to |
| paper_file_id | INTEGER NOT NULL            | Associated with paper file ID, to indicate the file of paper |
