JoatU Chef Recipes
==================

This Chef repository is forked from the [Intercity Chef
Repository](https://github.com/intercity/chef-repo), which aims to be the
easiest way to set up and configure a Rails server.

It is is heavily inspired by blog posts and chef recipes
from [37signals](http://37signals.com) and the
[Opscode Community Cookbooks](http://community.opscode.com).

## Features

Takes care of automatic installation and configuration of the following software
on a single server or multiple servers:

* nginx webserver
* Unicorn for running Ruby on Rails
* Multiple apps on one server
* Database creation and password generation
* Easy SSL configuration
* Deployment with Capistrano
* Configure ENV variables

### Ubuntu versions

* Ubuntu 12.04 LTS
* Ubuntu 14.04 LTS

### Databases

* MySQL
* PostgreSQL

## Getting started

The following paragraphs will guide you to begin managing the JoatU servers
through this repository.

### 1. Set up this repository

Clone the repository onto your own workstation, and change to the joatu-chef-repo folder. 
For example, to clone into your `~/Code` directory:

```sh
$ cd ~/Code
$ git clone git@github.com:joatuapp/joatu-chef-repo.git
$ cd joatu-chef-repo
```

Run bundle:

```sh
$ bundle install
```

### 2. Configure Chef

In order to access the chef server, you will first need an account at
[Opscode](https://manage.opscode.com/) and will have needed to be invited to
the JoatU organization. Email [Alex](mailto:alex@undergroundwebdevelopment) if
you need access.

### 3. Clone the JoatU codebase into place.

If you've already cloned the JoatU codebase onto your machine, make sure that
all your work there is committed & pushed, and then delete the repository.
Then, from within your joatu-chef-repo folder, run the following commands:

```
$ cd apps
$ git clone git@github.com:joatuapp/joatu-app.git
```

### 4. Deploy the application

Deploys are handled via capistrano. We currently have only one environment
configured (alpha), so that is the only environment that can be deployed.

First, to verify that everything is set up correctly run:

```sh
bundle exec cap alpha deploy:check
```

Finally to deploy, run:

```sh
bundle exec cap alpha deploy
```

This will deploy your app and run your database migrations.

**Congratulations!** You've deployed JoatU. Visit alpha.joatu.com to see your
changes!

## When you run into problems:

If something doesn't work or you need more instructions:

**Please!** email
[alex@undergroundwebdevelopment.com](mailto:alex@undergroundwebdevelopment.com).

## Resources and original authors

* Most of the cookbooks that are used in this repository are installed from the [Opscode Community Cookbooks](http://community.opscode.com).
* The `rails` and `bluepill` configuration is based off the cookbooks by [jsierles](https://github.com/jsierles) at https://github.com/jsierles/chef_cookbooks
