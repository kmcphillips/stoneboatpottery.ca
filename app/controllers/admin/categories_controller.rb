class Admin::CategoriesController < ApplicationController
  before_filter :require_login
  
  def index
    @categories = Category.all(:order => "name DESC")
  end

  def new
    @category = Category.new
  end
  
  def show
    @category = Category.find_by_permalink(params[:id])
  end
  
  def edit
    @category = Category.find_by_permalink(params[:id])
  end
  
  def update
    @category = Category.find_by_permalink(params[:id])
    
    if @category.update_attributes(params[:category])
      flash[:notice] = "Category successfully updated."
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render 'admin/categories/edit'
    end      
  end

  def create
    @category = Category.new(params[:category])
    
    if @category.save
      flash[:notice] = "Category successfully created."
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render 'admin/categories/new'
    end  
  end

  def destroy
    category = Category.find_by_permalink(params[:id])

    if category.subcategories.size > 0
      flash[:error] = "Can only delete empty categories. This category has #{category.subcategories.size} subcategories."
    else
      if category.delete
        flash[:notice] = "Category successfully deleted."
      else
        flash[:error] = category.errors.full_messages.to_sentence
      end
    end

    redirect_to admin_categories_path
  end
  
end
