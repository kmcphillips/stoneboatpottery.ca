class User < ActiveRecord::Base
  validates_presence_of :username, :password
  validates_uniqueness_of :username
  
  attr_protected :id, :username
  
  def self.authenticate(username, password)
    User.first(:conditions => ["username = ? AND password = ?", username.strip, encrypt(password.strip)]) unless username.blank? || password.blank?
  end
  
  def self.encrypt(password)
    password
  end
end
