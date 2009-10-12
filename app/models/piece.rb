class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable

  validates_presence_of :name, :description, :permalink
  
  attr_protected :id, :permalink

  include Permalink
  before_save :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.title)
  end
end
