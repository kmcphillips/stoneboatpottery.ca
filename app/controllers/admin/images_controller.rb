class Admin::ImagesController < ApplicationController
  before_filter :require_login

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(params[:image])

    if @image.save
      flash[:notice] = 'Image successfully created.'
      redirect_to admin_images_path     
    else
      flash[:errors] = @image.errors.full_messages.to_sentence
      render :action => :new
    end
  end

end
