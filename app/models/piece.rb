class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable

  validates_presence_of :name, :description, :permalink
  
  attr_protected :id
  attr_readonly :permalink

  include Permalink
  before_validation_on_create :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end
end
