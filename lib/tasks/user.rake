namespace :user do

  desc "Reset password for a user"
  task :change_password => :environment do
    User.all.each {|user| puts "  #{user.id}. #{user.username}" }
    puts ""
    print "Enter a user id: "
    
    if user = User.find_by_id(gets)
      print "Enter new password: "
      pass = gets.strip
      
      if user.change_password!(pass, pass)
        puts "Password has been changed"
      else
        puts "ERROR: #{user.errors.full_messages.to_sentence}"
        puts "Password has not been changed"
      end
    else
      puts "Invalid user id"
    end
  end
end
