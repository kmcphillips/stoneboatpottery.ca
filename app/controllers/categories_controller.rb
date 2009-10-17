class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all_active
  end

  def show
    @category = Category.all_active.find_by_permalink(params[:id])
  end

end
