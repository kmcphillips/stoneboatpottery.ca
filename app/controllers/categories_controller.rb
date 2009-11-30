class CategoriesController < ApplicationController
  
  def index
    @categories = Category.active
  end

  def show
    @category = Category.active.find_by_permalink(params[:id])
    @subcategories = @category.subcategories.all_active
    @title = @category.name
  end

end
