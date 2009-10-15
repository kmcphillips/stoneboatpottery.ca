class Admin::CategoriesController < ApplicationController
  before_filter :require_login, :set_objects
  
  def new
    @subcategory = @category.subcategories.new
  end
  
  def show
    @subcategory = @category.subcategories.find(params[:id])
  end
  
  def edit
    @subcategory = @category.subcategories.find(params[:id])
  end
  
  def update
    @subcategory = @category.subcategories.find(params[:id])
    
    if @subcategory.update_attributes(params[:subcategory])
      flash[:notice] = "Subcategory successfully updated."
      redirect_to admin_category_path(@category)
    else
      flash[:error] = @subcategory.errors.full_messages.to_sentence
      render 'admin/categories/subcaategories/edit'
    end      
  end

  def create
    @subcategory = @category.subcaategories.new(params[:subcategory])
    
    if @subcategory.save
      flash[:notice] = "Subcategory successfully created."
      redirect_to admin_category_path(@category)
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render 'admin/categories/subcategories/new'
    end  
  end

  def destroy
    subcategory = @category.subcategories.find(params[:id])

    if subcategory.delete
      flash[:notice] = "Subcategory successfully deleted."
    else
      flash[:error] = subcategory.errors.full_messages.to_sentence
    end

    redirect_to admin_category_path(@category)
  end

protected

  def set_objects
    @category = Category.find(params[:category_id])
  end  
end
