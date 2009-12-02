class SubcategoriesController < ApplicationController

  def show
    @category = Category.find_by_permalink(params[:category_id])
    @subcategory = @category.andand.subcategories.find_by_permalink(params[:id])
    @forms = @subcategory.forms.active
    @title = @subcategory.name

    if @category && (@category.active? || current_user)
      flash[:warning] = "This category is not active and can't be seen by users other than you." unless @category.active?
      @subcategories = @category.subcategories.active
      @title = @category.name
    else
      redirect_to_404
    end 
  end

end
