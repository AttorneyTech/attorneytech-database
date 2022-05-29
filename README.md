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
createdb <db-name>
```

![Screen Shot 2022-05-29 at 15 56 03](https://user-images.githubusercontent.com/89285959/170858231-e3850a49-dfde-4378-84a5-6adc7fc44621.png)

If this produces no response then this step was successful 

and you can skip over the remainder of this section.

<hr>

# Accessing a Database

```
psql <db-name>
```

Running the PostgreSQL interactive terminal program, called psql, 

which allows you to interactively enter, edit, and execute SQL commands.

![Screen Shot 2022-05-29 at 16 02 33](https://user-images.githubusercontent.com/89285959/170858418-8ad7f275-7039-4da8-9db9-499784d5a99b.png)

To get out of psql, type: <code>\q</code>


<hr>
