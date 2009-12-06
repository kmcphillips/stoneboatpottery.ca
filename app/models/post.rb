class Post < ActiveRecord::Base
  has_one :image, :as => :imageable

  validates_presence_of :body, :title
  
  attr_protected :id
  attr_readonly :generated

  acts_as_permalink
end
