class Post < ActiveRecord::Base
  include Permalink
  
  before_save :update_permalink
  
  
protected
  
  def update_permalink
    self.permalink = generate_permalink_for(self, self.title)
  end
end
