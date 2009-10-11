class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password
  
  def self.authenticate(username, password)
    User.find(:conditions => ["username ? AND password = ?", username.strip, encrypt(password.strip)])
  end
  
  def self.encrypt(password)
    password
  end
end
