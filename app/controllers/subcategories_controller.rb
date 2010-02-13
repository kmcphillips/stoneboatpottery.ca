class SubcategoriesController < ApplicationController

  def show
    @category = Category.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.find_by_permalink(params[:id]) if @category

    if @subcategory && (@subcategory.inherited_active? || current_user)
      flash[:warning] = "This subcategory is not active and can't be seen by users other than you." unless @subcategory.active?
      @forms = @subcategory.forms.active
      @inactive_forms = @subcategory.forms.inactive
      @title = @subcategory.name
    else
      redirect_to_404
    end 
  end

end
