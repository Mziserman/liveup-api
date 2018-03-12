# Liveup Api

## Setup
> Install dependencies

```
bundle install
```
> To setup your database ( only if new )

```
rake db:setup
```
> Migrate any changes to the database

```
rake db:migrate
```

## Commands
> Start the server

```
bundle exec rails s -p 3000 -b '0.0.0.0'
```

## Docker
> Start the docker

```
# The -d option puts it in the background - optional
docker-compose -p liveup up -d
```
> Access the rails app ( while is up )

```
# Only use it to run commands,
# if you want to modify files, do it in your folder !
docker-compose -p liveup exec web bash
```


### Notes :
- The database is mounted on the `/tmp/db` folder
- The app in `docker` and in your `folder` are the **same**
