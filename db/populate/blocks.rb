labels = ["about_joanna", "about_stoneboat", "contact", "wholesale"]

labels.each do |label|
  Block.create(:label => label)
end
