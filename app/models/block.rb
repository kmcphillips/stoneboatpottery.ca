class Block < ActiveRecord::Base
  has_one :image, :as => :imageable
  
end
