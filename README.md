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

1. Running the PostgreSQL interactive terminal program, called psql, which allows you to interactively enter, edit, and execute SQL commands.

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

<h2>Run PostgreSQL within Docker container</h2>

1. Pull the image

```
docker pull NAME:TAG
```
<img width="812" alt="Screen Shot 2022-05-31 at 00 08 58" src="https://user-images.githubusercontent.com/89285959/171034210-4aca8ce2-0028-418f-9350-ad8f18c11f67.png">

<img width="618" alt="Screen Shot 2022-05-31 at 00 09 10" src="https://user-images.githubusercontent.com/89285959/171034264-25ebe8c9-ec2c-4065-a434-8415413524be.png">

if not add tag, it will pull the latest version of image.

2. Create and run container.

```
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

<img width="1265" alt="Screen Shot 2022-05-31 at 00 25 40" src="https://user-images.githubusercontent.com/89285959/171035148-a495a5c8-9e0c-43a7-9bc0-ce216ede37c0.png">

<code>-d</code>--deatch<br>Run container in background and print container ID<br>
<code>--name</code><br>Container name<br>
<code>-p</code>--publish<br>set port<br>
<code>-e</code>--env<br>Set environment variable, set the username and password in postgresql<br>

and finally if we want to enter the CLI in postgre:

```
docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
```
<img width="763" alt="Screen Shot 2022-05-31 at 00 35 10" src="https://user-images.githubusercontent.com/89285959/171036256-03e8ee36-ce5b-4a49-b542-c5ff157480c9.png">

<code>-i</code>  --interactive<br>Keep STDIN open even if not attached<br>
<code>-t</code>  --tty<br>Allocate a pseudo-TTY<br>






