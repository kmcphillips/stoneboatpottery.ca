class Admin::FormsController < ApplicationController
  before_filter :require_login, :set_objects
  
  def new
    @form = @subcategory.forms.new
  end
  
  def show
    @form = @subcategory.forms.find_by_permalink(params[:id])
  end
  
  def edit
    @form = @subcategory.forms.find_by_permalink(params[:id])
  end
  
  def update
    @form = @subcategory.forms.find_by_permalink(params[:id])
    
    if @form.update_attributes(params[:form])
      flash[:notice] = "Form successfully updated."
      redirect_to admin_category_subcategory_path(@category, @subcategory)
    else
      flash[:error] = @form.errors.full_messages.to_sentence
      render 'admin/forms/edit'
    end      
  end

  def create
    @form = @subcategory.forms.new(params[:form])
    
    if @form.save
      flash[:notice] = "Form successfully created."
      redirect_to admin_category_subcategory_path(@category, @subcategory)
    else
      flash[:error] = @form.errors.full_messages.to_sentence
      render 'admin/forms/new'
    end  
  end

  def destroy
    form = @subcategory.forms.find_by_permalink(params[:id])

    if form.delete
      flash[:notice] = "Form successfully deleted."
    else
      flash[:error] = form.errors.full_messages.to_sentence
    end

    redirect_to admin_category_subcategory_path(@category, @subcategory)
  end

protected

  def set_objects
    @category = Category.find_by_permalink(params[:category_id])
    @subcategory = @category.subcategories.find_by_permalink(params[:subcategory_id])
  end  
end
