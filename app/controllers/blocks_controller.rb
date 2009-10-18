class BlocksController < ApplicationController
  before_filter :load_block  

  def about_joanna
  end
  
  def about_stoneboat
  end

  def contact
  end

  def wholesale
    if wholesale?
      @categories = Category.all_active
    else
      flash[:error] = "You are not authorized to view that area."
      redirect_to "/login"
    end
  end

protected

  def load_block
    @block = Block.find_by_label(params[:action])
  end

end
