# Choose PostgreSQL as the database for this project.

# Download PostgreSQL

Downloading PostgreSQL by homebrew
```
brew install postgresql
```

Start PostgreSQL service

```
brew services start postgresql
```

![Screen Shot 2022-05-29 at 15 52 31](https://user-images.githubusercontent.com/89285959/170858159-f9028907-bdd3-4c59-b702-6f472949d96e.png)

<hr>

# Creating a Database

```
createdb <dbname>
```

<img width="532" alt="Screen Shot 2022-05-29 at 16 31 57" src="https://user-images.githubusercontent.com/89285959/170859367-eec0b785-4a74-4051-8c13-53ac32e15c8e.png">


If this produces no response then this step was successful 

and you can skip over the remainder of this section.

<hr>

# Accessing a Database on localhost by CLI

```
psql <dbname>
```

Running the PostgreSQL interactive terminal program, called psql, 

which allows you to interactively enter, edit, and execute SQL commands.

```
psql -h [hostname] -p [port] [dbname] [username]
```

<img width="1243" alt="Screen Shot 2022-05-29 at 16 37 23" src="https://user-images.githubusercontent.com/89285959/170859566-de8a9594-176f-468b-8491-e948b063e420.png">


To get out of psql, type: <code>\q</code>

<hr>

# Connect to PostgreSQL by pgAdmin

After installing pgAdmin and execute it.

Register server

<img width="1277" alt="Screen Shot 2022-05-29 at 16 54 30" src="https://user-images.githubusercontent.com/89285959/170860466-4fa7c480-7725-4130-b5ff-f234e1207df3.png">

Enter a name, hostname, port 5432(default), database name and username.

<img width="1280" alt="Screen Shot 2022-05-29 at 16 54 48" src="https://user-images.githubusercontent.com/89285959/170860632-3ea3ece1-f6eb-4fb1-ab69-f3e1f7c16867.png">
<img width="1280" alt="Screen Shot 2022-05-29 at 17 04 36" src="https://user-images.githubusercontent.com/89285959/170860646-09589c68-e6cd-44a5-9b11-c83898a75e4b.png">

Done

<img width="1279" alt="Screen Shot 2022-05-29 at 16 59 17" src="https://user-images.githubusercontent.com/89285959/170860663-09b97954-1112-4110-863d-6cdc1d0747e8.png">

<hr>







