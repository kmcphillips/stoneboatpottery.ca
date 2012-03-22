require 'lib/date_scopes'
ActiveRecord::Base.extend(DateScopes::ClassMethods)

class ActiveRecord::Base
  def self.truncate!
    case connection.adapter_name 
      when "MySQL" then
        connection.execute("TRUNCATE #{table_name}")
      when "SQLite" then
        connection.execute("DELETE FROM #{table_name}")
        connection.execute("VACUUM")
      else
        raise "Unknown database adapter. Cannot truncate."
    end
    true
  end
end