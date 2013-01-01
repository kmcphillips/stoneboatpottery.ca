class Block < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy

  validates_uniqueness_of :label

  attr_protected :id
  attr_readonly :label

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

end
