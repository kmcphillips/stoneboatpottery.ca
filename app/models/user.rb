class User < ActiveRecord::Base
  validates_presence_of :username, :password_hash
  validates_uniqueness_of :username
  
  attr_protected :id
  
  def self.authenticate(username, password)
    User.first(:conditions => ["username = ? AND password_hash = ?", username.strip, encrypt(password.strip)]) unless username.blank? || password.blank?
  end
  
  def self.encrypt(password)
    Digest::SHA1.hexdigest password
  end
end
