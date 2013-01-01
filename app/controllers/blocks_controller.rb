class BlocksController < ApplicationController
  before_filter :load_block

  def about
    @about = [Block.about_stoneboat, Block.about_joanna]
  end

  def contact
  end

  def teaching

  end

  protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
