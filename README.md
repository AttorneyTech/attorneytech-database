# Choose PostgreSQL as the database for this project.

<h2>Download PostgreSQL</h2>

1. Downloading PostgreSQL by homebrew

```
brew install postgresql
```

2. Start PostgreSQL service

```
brew services start postgresql
```

![Screen Shot 2022-05-29 at 15 52 31](https://user-images.githubusercontent.com/89285959/170858159-f9028907-bdd3-4c59-b702-6f472949d96e.png)

<hr>

<h2>Creating a Database</h2>

```
createdb <dbname>
```

<img width="532" alt="Screen Shot 2022-05-29 at 16 31 57" src="https://user-images.githubusercontent.com/89285959/170859367-eec0b785-4a74-4051-8c13-53ac32e15c8e.png">

If this produces no response then this step was successful and you can skip over the remainder of this section.

<hr>

<h2>Accessing a Database on localhost by CLI</h2>

<h3>1. Running the PostgreSQL interactive terminal program.</h3>

```
psql <dbname>
```

or

```
psql -h [hostname] -p [port] [dbname] [username]
```

<img width="1243" alt="Screen Shot 2022-05-29 at 16 37 23" src="https://user-images.githubusercontent.com/89285959/170859566-de8a9594-176f-468b-8491-e948b063e420.png">

To get out of psql, type: <code>\q</code>

<hr>

<h2>Connect to PostgreSQL by pgAdmin</h2>

After installing pgAdmin and execute it.

Register server

<img width="1277" alt="Screen Shot 2022-05-29 at 16 54 30" src="https://user-images.githubusercontent.com/89285959/170860466-4fa7c480-7725-4130-b5ff-f234e1207df3.png">

Enter a name, hostname, port 5432(default), database name and username.

<img width="1280" alt="Screen Shot 2022-05-29 at 16 54 48" src="https://user-images.githubusercontent.com/89285959/170860632-3ea3ece1-f6eb-4fb1-ab69-f3e1f7c16867.png">
<img width="1280" alt="Screen Shot 2022-05-29 at 17 04 36" src="https://user-images.githubusercontent.com/89285959/170860646-09589c68-e6cd-44a5-9b11-c83898a75e4b.png">

Done

<img width="1279" alt="Screen Shot 2022-05-29 at 16 59 17" src="https://user-images.githubusercontent.com/89285959/170860663-09b97954-1112-4110-863d-6cdc1d0747e8.png">

<hr>

<h2>Run PostgreSQL and pgadmin4 within Docker container</h2>

<h3>1. Download docker form brew</h3>

```
brew install --cask docker
```

Because docker is a system-level package, you cannot install it using brew install, and must use <code>--cask</code> instead.

Then launch the Docker app. Click next. It will ask for privileged access. Confirm.

A whale icon should appear in the top bar. Click it and wait for "Docker is running" to appear.

<h3>2. Pull the image</h3>

```
docker pull NAME:TAG
```

<img width="812" alt="Screen Shot 2022-05-31 at 00 08 58" src="https://user-images.githubusercontent.com/89285959/171034210-4aca8ce2-0028-418f-9350-ad8f18c11f67.png">

<img width="831" alt="Screen Shot 2022-05-31 at 21 53 10" src="https://user-images.githubusercontent.com/89285959/171218355-62f2eab7-ddda-4311-831a-f3cd464eae45.png">

if not add tag, it will pull the latest version of image.

<h3>3. Create and run container.</h3>

```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

<img width="678" alt="Screen Shot 2022-05-31 at 23 51 57" src="https://user-images.githubusercontent.com/89285959/171218860-23df688f-4a56-47b3-9188-cbbbc06de622.png">

<img width="687" alt="Screen Shot 2022-05-31 at 23 54 01" src="https://user-images.githubusercontent.com/89285959/171219063-f2ab7068-407e-4651-93ae-9314acd797e4.png">

<code>--name</code><br>Container name<br>

<code>-e</code>--env<br>Set environment variable, set the username and password in postgresql<br>

<code>-p</code>--publish<br>set port<br>

<code>-d</code>--deatch<br>Run container in background and print container ID<br>

and finally if we want to enter the CLI in postgre:

```
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```

<img width="763" alt="Screen Shot 2022-05-31 at 00 35 10" src="https://user-images.githubusercontent.com/89285959/171036256-03e8ee36-ce5b-4a49-b542-c5ff157480c9.png">

<code>-i</code> --interactive<br>Keep STDIN open even if not attached<br>
<code>-t</code> --tty<br>Allocate a pseudo-TTY<br>

<h3>4. Get the IP address of our postgres.</h3>

```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' <container-name>
```

When Docker creates a container,<br>
it will randomly select an address for the container to use within the private network range defined in RFC 1918,<br>
which is also commonly known as the same network segment.<br>
Using this bridge, the container can communicate with the host system and other containers.<br><br>
（Qoute from :<br>
https://mileslin.github.io/2019/05/%E7%9E%AD%E8%A7%A3-Docker-%E7%9A%84%E9%A0%90%E8%A8%AD%E7%B6%B2%E8%B7%AF%E8%A8%AD%E7%BD%AE/
）

<img width="830" alt="Screen Shot 2022-05-31 at 23 54 51" src="https://user-images.githubusercontent.com/89285959/171222187-81b49123-ba3c-4b87-81a6-28dff7d25519.png">

<h3> 5. Open pgadmin in browser</h3>

URL:http://localhost:5050<br>

<img width="1280" alt="Screen Shot 2022-05-31 at 23 55 42" src="https://user-images.githubusercontent.com/89285959/171222710-a17ebf3b-fa6e-40a2-8d32-4e108e02f6b2.png">

Enter the information we just got.

<img width="1280" alt="Screen Shot 2022-05-31 at 23 56 23" src="https://user-images.githubusercontent.com/89285959/171222807-090d185b-41fb-45c7-ab9c-2d10d247e837.png">

<img width="1280" alt="Screen Shot 2022-05-31 at 23 56 35" src="https://user-images.githubusercontent.com/89285959/171223051-54f73878-a127-4938-8dc9-7b405bf7f47b.png">

Done
