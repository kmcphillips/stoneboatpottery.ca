labels = [["about_joanna", "/about_joanna"], ["about_stoneboat", "/about_stoneboat"], ["contact", "/contact"], ["wholesale", "/wholesale"]]

labels.each do |row|
  Block.create!(:label => row[0], :section_path => row[1], :title => "", :body => "")
end
