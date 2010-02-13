class Post < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy

  validates_presence_of :body, :title
  
  attr_protected :id

  xss_terminate :except => [:permalink]

  acts_as_permalink

  def system?
    self.type == "SystemPost"
  end
end
