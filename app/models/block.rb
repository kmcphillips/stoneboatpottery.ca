class Block < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy

  validates_uniqueness_of :label

  date_scopes

  def label_display
    case label
    when "about_joanna"
      "About JoAnna"
    when "about_stoneboat"
      "About Stoneboat"
    else
      label.humanize
    end
  end

  class << self

    def method_missing(method, *args)
      # find_by_label is built using method_missing so using it here causes infinite recursion
      self.where(label: method).first || super
    end

  end

end
