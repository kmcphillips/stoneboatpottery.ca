# Stoneboat Pottery

[Kevin McPhillips](mailto:github@kevinmcphillips.ca)

[http://stoneboatpottery.ca](http://stoneboatpottery.ca)


## About

This is a full website, written in Ruby on Rails. It provides a full content management to the user including image uploading and automatic resizing provided by paperclip and rmagick.

Recently updated for rails 3.2.8. Some things that maybe should have be re-written were not, but it all works.


## Quick Setup

With an OS X or Linux machine with ruby and rubygems installed, you should be able to go from 0 to running in under three minutes.

### For the impatient

    $ git clone git://github.com/kmcphillips/stoneboat_pottery.git
    $ cd stoneboat_pottery
    $ cp config/database.yml.sqlite3 config/database.yml
    $ bundle
    $ rake db:migrate
    $ rake db:populate
    $ railsserver

Point your browser to [http://localhost:3000/](http://localhost:3000/) and you should be set to go.


## Setup

This all works under the assumption that you have Ruby and Rubygems installed.
Feel free to contact me if you're having problems. [github@kevinmcphillips.ca](mailto:github@kevinmcphillips.ca)


### Create a Database

For simplicity this uses a SQLite database. There are instructions below on how to create a MySQL database. MySQL is faster and should be used for a production system, but this is much easier just to get going for now.

The SQLite database will get created with the migrations. Magic.


### Get the source

Clone the git repo to get the source.

    $ git clone git://github.com/kmcphillips/stoneboat_pottery.git


### Configure it

Copy in the config files needed.

    $ cd stoneboat_development
    $ cp config/database.yml.sqlite3 config/database.yml


### Install the required gems

This is easy now with bundler.

    $ bundle

If you don't have ImageMagick and the dev libs for it, [godspeed](https://www.google.ca/?q=how+to+install+imagemagick).


### Create and populate the database

After the migrations, db:populate will seed required data, including a test user.

    $ rake db:migrate
    $ rake db:populate


### Done

Start the server and direct your browser to [http://localhost:3000/](http://localhost:3000/)

    $ rails server

The admin area can be reached at [http://localhost:3000/admin/](http://localhost:3000/admin/) and the username and password that were created with the populate are test/test.


## MySQL Database rather than SQLite

SQLite is nice and easy but it's not fast. MySQL is much better for a real app. Modify the above instructions to do:

    $ cp config/database.yml.mysql config/database.yml
    $ mysql -u root -e "CREATE DATABASE stoneboat_development"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON stoneboat_development.* TO 'stoneboat'@'localhost' IDENTIFIED BY 'stoneboat'"
    $ mysql -u root -e "FLUSH PRIVILEGES"

You'll need to install the mysql gem, copy in the appropriate config file, and create the database in your MySQL instance. Your root user may require different credentials.


## Tests

There's a suite of spec tests for all models and helpers and some of the controllers.

With SQLite the database will get created automatically. With MySQL you'll need to create the test database.

    $ mysql -u root -e "CREATE DATABASE stoneboat_test"
    $ mysql -u root -e "GRANT ALL PRIVILEGES ON stoneboat_test.* TO 'stoneboat'@'localhost' IDENTIFIED BY 'stoneboat'"
    $ mysql -u root -e "FLUSH PRIVILEGES"

Next, clone your current database into your test database.

    $ rake db:test:clone

Then run them!

    $ bundle exec rspec


## Feedback

Contact me at [github@kevinmcphillips.ca](mailto:github@kevinmcphillips.ca) with questions or feedback.

