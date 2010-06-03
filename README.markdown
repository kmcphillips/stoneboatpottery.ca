# Stoneboat Pottery

[Kevin McPhillips](mailto:kimos-github@gleep.ca)

[http://stoneboatpottery.ca](http://stoneboatpottery.ca)


## About

This is a full website, written in Ruby on Rails. It provides a full content management to the user including image uploading and automatic resizing provided by paperclip and rmagick. 


## Quick Setup

With an OS X or Linux machine and MySQL installed, you should be able to go from 0 to running in under three minutes. 

### For the impatient

The MySQL commands may be different depending on your database credentials.

    $ sudo gem install haml will_paginate rmagick sqlite3-ruby
    $ git clone git://github.com/kimos/stoneboat_pottery.git
    $ cd stoneboat_pottery
    $ cp config/database.yml.sqlite3 config/database.yml
    $ rake db:migrate
    $ rake db:populate
    $ ./script/server

Point your browser to [http://localhost:3000/](http://localhost:3000/) and you should be set to go.


## Setup

This all works under the assumption that you have Ruby and Rubygems installed. 
Feel free to contact me if you're having problems. [kimos-github@gleep.ca](mailto:kimos-github@gleep.ca)


### Create a Database

For simplicity this uses a SQLite database. There are instructions below on how to create a MySQL database. MySQL is faster and should be used for a production system, but this is much easier just to get going for now.

The SQLite database will get created with the migrations. Magic.


### Install the required gems

The only tricky on is rmagick which depends on ImageMagick locally. On Linux it's usually just installing a package, but on OS X it's a little more intense.  

    $ sudo gem install haml will_paginate rmagick sqlite3-ruby

If rmagick won't install, then just omit it from the line above. The app will run but image uploads will not work. On linux you'll have to install the ImageMagick dev libraries that should be in the repo for your distro. On OS X try something like this:  http://github.com/masterkain/ImageMagick-sl


### Get the source

Clone the git repo to get the source.

    $ git clone git://github.com/kimos/stoneboat_pottery.git


### Configure it

Copy in the config files needed.

    $ cd stoneboat_development
    $ cp config/database.yml.sqlite3 config/database.yml


### Create and populate the database

After the migrations, db:populate will seed required data, including a test user.

    $ rake db:migrate
    $ rake db:populate


### Done

Start the server and direct your browser to [http://localhost:3000/](http://localhost:3000/)

    $ ./script/server

The admin area can be reached at [http://localhost:3000/admin/](http://localhost:3000/admin/) and the username and password that were created with the populate are test/test.


## MySQL Database rather than SQLite

SQLite is nice and easy but it's not fast. MySQL is much better for a real app. Modify the above instructions to do:

    $ sudo gem install mysql
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

Be sure you have the spec gems.

    $ sudo gem install rspec rspec-rails progressbar

Then run them!

    $ rake spec


## Feedback

Contact me at [kimos-github@gleep.ca](mailto:kimos-github@gleep.ca) with questions or feedback.

