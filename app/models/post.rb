class Post < ActiveRecord::Base
  validates_uniqueness_of :permalink
  validates_presence_of :body, :title
  
  attr_protected :id
  attr_readonly :generated, :permalink
  
  include Permalink
  before_save :update_permalink
  
protected
  
  def update_permalink
    self.permalink = generate_permalink_for(self, self.title)
  end
end
