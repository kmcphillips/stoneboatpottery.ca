class Form < ActiveRecord::Base
  has_many :images, :as => :imageable
  belongs_to :subcategory
  
  validates_presence_of :subcategory
end
