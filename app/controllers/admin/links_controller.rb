class Admin::LinksController < ApplicationController
  before_filter :require_login
  
  def index
    @links = Link.all(:order => "updated_at DESC")
  end

  def new
    @link = Link.new
  end
  
  def show
    @link = Link.find(params[:id])
  end
  
  def edit
    @link = Link.find(params[:id])
  end
  
  def update
    @link = Link.find(params[:id])
    
    if @link.update_attributes(params[:link])
      flash[:notice] = "Link successfully updated."
      redirect_to admin_links_path
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      render 'admin/links/edit'
    end      
  end

  def create
    @link = Link.new(params[:link])
    
    if @link.save
      flash[:notice] = "Link successfully created."
      redirect_to admin_links_path
    else
      flash[:error] = @link.errors.full_messages.to_sentence
      render 'admin/links/new'
    end  
  end

  def destroy
    link = Link.find(params[:id])

    if link.delete
      flash[:notice] = "Link successfully deleted."
    else
      flash[:error] = @link.errors.full_messages.to_sentence
    end

    redirect_to admin_links_path
  end
  
end
