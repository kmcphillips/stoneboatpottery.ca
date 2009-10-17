class FormsController < ApplicationController

  def show
    @category = Category.all_active.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.find_by_permalink(params[:subcategory_id])
    @form = @subcategory.forms.find_by_permalink(params[:id])
  end

end
