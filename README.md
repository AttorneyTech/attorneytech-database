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
