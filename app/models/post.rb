class Post < ActiveRecord::Base
  # has_one :image, :as => :imageable
  has_many :images, :as => :imageable do
    def primary
      first(:conditions => {:primary => true})
    end
  end

  validates_uniqueness_of :permalink
  validates_presence_of :body, :title
  
  attr_protected :id
  attr_readonly :generated, :permalink
  
  include Permalink
  before_validation_on_create :update_permalink
  
protected
  
  def update_permalink
    self.permalink = generate_permalink_for(self, self.title)
  end
end
