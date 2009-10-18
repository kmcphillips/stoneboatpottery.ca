class SubcategoriesController < ApplicationController

  def show
    @category = Category.all_active.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.all_active.find_by_permalink(params[:id])
    @forms = @subcategory.forms.all_active
    @title = @subcategory.name
  end

end
