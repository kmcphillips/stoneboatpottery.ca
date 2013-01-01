class BlocksController < ApplicationController
  before_filter :load_block

  def about
    @about = [Block.find_by_label("about_stoneboat"), Block.find_by_label("about_joanna")]
  end

  def contact
  end

protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
