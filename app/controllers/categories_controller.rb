class CategoriesController < ApplicationController
  
  def index
    @categories = Category.active
    @inactive_categories = Category.inactive
    @block = Block.find_by_label("categories")
  end

  def show
    @category = Category.find_by_permalink(params[:id])

    if @category && (@category.inherited_active? || current_user)
      flash[:warning] = "This category is not active and can't be seen by users other than you." unless @category.active?
      @subcategories = @category.subcategories.active
      @inactive_subcategories = @category.subcategories.inactive
      @title = @category.name
    else
      redirect_to_404
    end    

  end

end
