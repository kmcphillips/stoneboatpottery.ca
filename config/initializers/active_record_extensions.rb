require File.join(Rails.root, 'lib', 'date_scopes')

ActiveRecord::Base.extend(DateScopes::ClassMethods)
