class FormsController < ApplicationController

  def show
    @category = Category.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.find_by_permalink(params[:subcategory_id]) if @category
    @form = @subcategory.forms.find_by_permalink(params[:id]) if @subcategory

    if @form && (@form.inherited_active? || current_user)
      flash[:warning] = "This form is not active and can't be seen by users other than you." unless @form.active?
      @title = @form.name
    else
      redirect_to_404
    end
  end

end
