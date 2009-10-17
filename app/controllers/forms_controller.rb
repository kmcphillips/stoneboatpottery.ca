class FormsController < ApplicationController

  def show
    @category = Category.all_active.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.all_active.find_by_permalink(params[:subcategory_id])
    @form = @subcategory.forms.all_active.find_by_permalink(params[:id])
  end

end
