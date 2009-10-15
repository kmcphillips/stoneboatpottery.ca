class BlocksController < ApplicationController
  
  def about_joanna
    @block = Block.find_by_label('about_joanna')
  end
  
  def about_stoneboat
    @block = Block.find_by_label('about_stoneboat')
  end
end
