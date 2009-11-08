WholesalePassword.connection.execute("truncate wholesale_passwords;")

WholesalePassword.create!(:password => "wholesale")
