users = [
          {:username => "test", :password => "test"}
        ]

users.each do |current|
  user = User.find_by_username(current[:username])
  
  if user
    user.update_attributes(:password_hash => User.encrypt(current[:password]))
  else
    user = User.new(:password_hash => User.encrypt(current[:password]))
    user.username = current[:username]
    user.save!
  end
end