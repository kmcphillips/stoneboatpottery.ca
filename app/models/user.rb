class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password
  
  def self.authenticate(username, password)
    User.first(:conditions => ["username = ? AND password = ?", username.strip, encrypt(password.strip)]) unless username.blank? || password.blank?
  end
  
  def self.encrypt(password)
    password
  end
end
