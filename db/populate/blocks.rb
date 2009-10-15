labels = ["about_joanna", "about_stoneboat", "contact"]

labels.each do |label|
  Block.create(:label => label)
end
