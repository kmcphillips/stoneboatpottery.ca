Block.connection.execute("truncate blocks;")

blocks = [
          {:label => "about_joanna", :section_path => "/about", :accepts_image => true},
          {:label => "about_stoneboat", :section_path => "/about", :accepts_image => true},
          {:label => "contact", :section_path => "/contact", :accepts_image => false},
          {:label => "wholesale", :section_path => "/wholesale", :accepts_image => false}
        ]

blocks.each do |block|
  Block.create!(block.merge({:body => ""}))
end
