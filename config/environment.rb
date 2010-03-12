RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  ## Use one of your favorite database engine. You should require it depending on what you pick.
  #config.gem "mysql", :version => ">=2.8.1"
  #config.gem "sqlite3-ruby", :lib => "sqlite3", :version => ">=1.2.4"
  
  config.gem "haml", :version => ">=2.2.7"
  config.gem "will_paginate", :version => ">=2.2.2"
  config.gem "rmagick", :lib => "RMagick", :version => ">=2.12.2"

  config.time_zone = 'UTC'
end

Time::DATE_FORMATS[:simple_short] = lambda { |time| time.strftime("%B #{time.day.ordinalize}, %Y") }
Time::DATE_FORMATS[:table] = "%b %e, %Y %m:%M%p"

ALT_TAG_DEFAULT = "Stoneboat Pottery"
THUMB_NOT_FOUND_IMAGE = "/images/template/thumbknown.png"

EMAIL = {:main => "joanna@stoneboatpottery.ca", :admin => "admin@gleep.ca"}

META = {
  :keywords => "stoneboat pottery, stone boat, pottery, ceramics, ceramic, winnipeg, manitoba, canada, joanna lange, functional, dinnerware, dishes, sculpture, dragonfly, clifton, clifton studios",
  :description => "Stoneboat Pottery"
}
