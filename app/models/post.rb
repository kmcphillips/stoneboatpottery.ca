class Post < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy

  validates_presence_of :body, :title
  
  attr_protected :id

  xss_terminate :except => [:permalink]

  acts_as_permalink

  named_scope :user_created, :conditions => {:type => nil}
  date_scopes

  def system?
    self.type == "SystemPost"
  end

end
