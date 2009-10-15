class WholesalePassword < ActiveRecord::Base
  validates_presence_of :password
  validates_uniqueness_of :password
  validate :password_characters
  
  attr_protected :id

  def usable?
    active && (!expires_at || expires_at > Time.now)    
  end

protected

  def password_characters
    errors.add(:password, "must only contain letter, numbers, underscores, and dashes.") unless password =~ /^[a-zA-Z0-9_-]+$/
  end
end
