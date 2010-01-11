# Stoneboat Pottery

Kevin McPhillips

[http://stoneboatpottery.ca](http://stoneboatpottery.ca)


## About

This is a full website, written in Ruby on Rails. It provides a full content management to the user including image uploading and automatic resizing provided by paperclip and rmagick. 


## Quick Setup

With an OS X or Linux machine and MySQL installed, you should be able to go from 0 to running in under three minutes. 

### For the impatient

The MySQL commands may be different depending on your database credentials.

    $ mysql -u root -e "CREATE DATABASE stoneboat_development"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON stoneboat_development.* TO 'stoneboat'@'localhost' IDENTIFIED BY 'stoneboat'"
    $ mysql -u root -e "FLUSH PRIVILEGES"
    $ sudo gem install haml andand will_paginate rmagick
    $ git clone git://github.com/kimos/stoneboat_pottery.git
    $ cd stoneboat_development
    $ cp config/database.yml.example config/database.yml
    $ rake db:migrate
    $ rake db:populate
    $ ./script/server


## Setup

### Create a Database

Create a MySQL database called "stoneboat_development" with the username and password "stoneboat/stoneboat". The MySQL commands would look something like this.

    $ mysql -u root -e "CREATE DATABASE stoneboat_development"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON stoneboat_development.* TO 'stoneboat'@'localhost' IDENTIFIED BY 'stoneboat'"
    $ mysql -u root -e "FLUSH PRIVILEGES"

With some very small changes this could use a SQLite database, but I'll leave that as an exercise to the reader.


### Install the required gems

The only tricky on is rmagick which depends on ImageMagick locally. On Linux it's usually just installing a package, but on OS X it's a little more intense. 

    $ sudo gem install haml andand will_paginate rmagick


### Get the source

Clone the git repo to get the source.

    $ git clone git://github.com/kimos/stoneboat_pottery.git


### Configure it

Copy in the config files needed.

    $ cd stoneboat_development
    $ cp config/database.yml.example config/database.yml


### Create and populate the database

After the migrations, db:populate will seed required data, including a test user.

    $ rake db:migrate
    $ rake db:populate


### Done

Start the server and direct your browser to [http://localhost:3000/](http://localhost:3000/)

    $ ./script/server

The admin area can be reached at [http://localhost:3000/admin/](http://localhost:3000/admin/) and the username and password that were created with the populate are test/test.


## Feedback

Contact me at [kimos-github@gleep.ca](mailto:kimos-github@gleep.ca) with questions or feedback.

