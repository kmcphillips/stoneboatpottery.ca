module DateScopes
  module ClassMethods
    def date_scopes
      named_scope :created_between, lambda {|from, to| {:conditions => ["created_at >= ? AND created_at < ?", from, to], :order => "created_at ASC"}}
      named_scope :updated_between, lambda {|from, to| {:conditions => ["updated_at >= ? AND updated_at < ?", from, to], :order => "updated_at ASC"}}
    end
  end
end