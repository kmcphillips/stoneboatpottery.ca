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

    responds_to_parent do
      if @image.save
        begin
          @imageable = params[:imageable_type].constantize.find(params[:imageable_id])
          if @imageable.respond_to?(:image)
            @imageable.image.andand.destroy   # This puts exceptions in the logs but works so i'm just going to leave it as-is
            @imageable.image = @image
          elsif @imageable.respond_to?(:images)
            @imageable.images << @image
          else
            raise StandardError, "does not respond to image or images"
          end

          flash.now[:notice] = 'Image successfully added.'
        rescue => e
          flash.now[:error] = 'Unable to associate image to object. Contact administrator.'
          raise e
        end
      else
        flash.now[:error] = @image.errors.full_messages.to_sentence
      end

      render :update do |page|
        page.call "upload_after"
        page.replace_html :image_container, :partial => "shared/image_container", :locals => {:imageable => @imageable}
        page.replace_html :flashes, :partial => "shared/flashes"
      end
    end
  end

end
