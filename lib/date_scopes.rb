module DateScopes
  module ClassMethods
    def date_scopes
      scope :created_between, lambda {|from, to| where(["created_at >= ? AND created_at < ?", from, to]).order("created_at ASC") }
      scope :updated_between, lambda {|from, to| where(["updated_at >= ? AND updated_at < ?", from, to]).order("updated_at ASC") }
    end
  end
end
