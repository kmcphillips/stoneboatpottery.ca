class FormsController < ApplicationController

  def show
    @category = Category.active.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.active.find_by_permalink(params[:subcategory_id])
    @form = @subcategory.forms.active.find_by_permalink(params[:id])
    @title = @form.name
  end

end
