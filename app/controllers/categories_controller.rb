class CategoriesController < ApplicationController
  
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
