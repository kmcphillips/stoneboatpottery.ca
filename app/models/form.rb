class Form < ActiveRecord::Base
  has_many :images, :as => :imageable
  belongs_to :subcategory
  
  validates_presence_of :subcategory
  
  include Permalink
  before_save :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end
end
