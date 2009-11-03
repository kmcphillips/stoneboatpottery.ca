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

    respond_to do |wants|
      wants.js do
        if @image.save
          flash.now[:notice] = 'Image successfully added.'
        else
          flash.now[:error] = @image.errors.full_messages.to_sentence
        end

        render :update do |page|
          page.replace_html :image_container, :partial => "shared/image_container"
          page.replace_html :flashes, :partial => "shared/flashes"
        end
      end
    end
  end

end
