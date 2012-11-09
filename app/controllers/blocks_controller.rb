class BlocksController < ApplicationController
  before_filter :load_block

  def about
    @about_joanna = Block.find_by_label("about_joanna")
    @about_stoneboat = Block.find_by_label("about_stoneboat")
  end

  def contact
  end

protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
