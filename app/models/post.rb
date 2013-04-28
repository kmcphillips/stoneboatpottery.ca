class Post < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy

  validates_presence_of :body, :title

  accepts_nested_attributes_for :image

  attr_protected :id

  acts_as_permalink

  scope :user_created, where(:type => nil)
  date_scopes

  def system?
    self.type == "SystemPost"
  end

end
