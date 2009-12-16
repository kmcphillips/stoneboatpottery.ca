class User < ActiveRecord::Base
  validates_presence_of :username, :password_hash
  validates_uniqueness_of :username
  
  attr_protected :id
  attr_readonly :username
  
  def self.authenticate(username, password)
    User.first(:conditions => ["username = ? AND password_hash = ?", username.strip, encrypt(password.strip)]) unless username.blank? || password.blank?
  end
  
  def self.encrypt(password)
    Digest::SHA1.hexdigest password
  end

  def change_password(password, password_confirm)
    if password && password_confirm
      if password == password_confirm
        if password.length >= 4
          self.update_attributes(:password_hash => User.encrypt(password))
        else
          self.errors.add_to_base "Password must be at least four characters."
        end
      else
        self.errors.add_to_base "Passwords do not match."
      end
    else
      self.errors.add_to_base "Password was not passed for update."
    end

    !self.errors.any?
  end
end
