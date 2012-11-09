Block.truncate!
blocks = [
          {:label => "about_joanna", :section_path => "/about", :accepts_image => true},
          {:label => "about_stoneboat", :section_path => "/about", :accepts_image => true},
          {:label => "contact", :section_path => "/contact", :accepts_image => false},
          {:label => "categories", :section_path => "/categories", :accepts_image => false}
        ]

blocks.each do |block|
  Block.create!(block.merge({:body => ""}))
end


User.truncate!

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
