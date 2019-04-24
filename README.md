# README

# Project

Rails Event Store Entities Tracker

## Install

### Clone the repository

```shell
git@github.com:assist-software/rails-eventstore-entities-tracker.git
cd path_to_project
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.5.1`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 2.5.1
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle
```

### Configure the database

Create a `local_env.yml` file under `config` folder and add:

```shell
USERNAME: YOUR_USERNAME
PASSWORD: YOUR_PASSWORD
DATABASE: YOUR_DEV_DATABASE

TEST_DATABASE: YOUR_TEST_DATABASE
PROD_DATABASE: YOUR_PROD_DATABASE
```

### Initialize the database

```shell
rails db:create db:migrate
```

## Server

```shell
rails s
```
