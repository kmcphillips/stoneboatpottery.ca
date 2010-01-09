class Admin::ImagesController < ApplicationController
  before_filter :require_login

  def new
    @image = Image.new
  end

  def create
    respond_to do |wants|
      wants.js do
        responds_to_parent do
          begin
            @imageable = params[:imageable_type].constantize.find(params[:imageable_id]) rescue nil
            old_img = nil

            if @imageable && (@imageable.respond_to?(:image) || @imageable.respond_to?(:images))
              if @imageable.respond_to?(:image)
                @image = Image.new(params[:image].merge(:imageable => @imageable))
              elsif @imageable.respond_to?(:images)
                @image = @imageable.images.new(params[:image])
              end

              if @image.save
                flash.now[:notice] = 'Image successfully added.'
              else
                flash.now[:error] = @image.errors.full_messages.to_sentence
              end
              
              @imageable.reload
            else
              flash.now[:error] = 'Unable to associate image to object. Contact administrator.'
              logger.error "Error associating image to object with params: #{params.inspect}"
            end
          rescue => e
            logger.error "Error responding to image upload"
            logger.error e, e.backtrace
    
            flash.now[:error] = "There was an error uploading image. Please try again or contact administrator. "
          end

          render :update do |page|
            page.call "upload_after"
            page.replace :image_container, :partial => "shared/image_single", :locals => {:imageable => @imageable} if @imageable.andand.respond_to?(:image)
            page.replace :images_container, :partial => "shared/image_multiple", :locals => {:imageable => @imageable} if @imageable.andand.respond_to?(:images)
            page.call "init_facebox"
            page.replace_html :flashes_now, :partial => "shared/flashes"
          end
        end
      end
    end
  end

  def destroy
    respond_to do |wants|
      wants.js do
        @image = Image.find_by_id(params[:id])
        imageable = @image.imageable if @image

        render :update do |page|
          if imageable.respond_to?(:image)
            if @image.destroy
              flash.now[:notice] = "Image removed successfully."
            else
              flash.now[:error] = @image.errors.full_messages.to_sentence
            end

            imageable.reload
            page.replace :image_container, :partial => "shared/image_single", :locals => {:imageable => imageable}
          elsif imageable.respond_to?(:images)
            if @image.destroy
              flash.now[:notice] = "Image removed successfully."
            else
              flash.now[:error] = @image.errors.full_messages.to_sentence
            end

            imageable.reload
            page.replace :images_container, :partial => "shared/image_multiple", :locals => {:imageable => imageable}
          else
            flash.now[:error] = "Unable to find image. Contact administrator."
            logger.error "Error deleting image with params: #{params.inspect}"
          end

          page.replace_html :flashes_now, :partial => "shared/flashes"
        end
      end
    end
  end

  def make_primary
    respond_to do |wants|
      wants.js do
        @image = Image.find_by_id(params[:id])
        imageable = @image.imageable

        if imageable.respond_to?(:images)
          @image.primary = true

          if @image.save
            flash.now[:notice] = "Changed primary image."
          else
            flash.now[:error] = @image.errors.full_messages.to_sentence
          end

          imageable.reload

          render :update do |page|
            page.replace :images_container, :partial => "shared/image_multiple", :locals => {:imageable => imageable}
            page.replace_html :flashes_now, :partial => "shared/flashes"
          end
        end
      end
    end
  end

end
