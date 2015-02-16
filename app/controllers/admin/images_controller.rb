class Admin::ImagesController < AuthenticatedController

  def new
    @image = Image.new
  end

  def create
    respond_to do |wants|
      wants.js do
        begin
          @imageable = params[:imageable_type].constantize.find(params[:imageable_id]) rescue nil
          old_img = nil

          if @imageable && (@imageable.respond_to?(:image) || @imageable.respond_to?(:images))
            if @imageable.respond_to?(:image)
              if @imageable.image
                @image = @imageable.image
                @image.image = params[:image][:image]
              else
                @image = Image.new(params[:image].merge(:imageable => @imageable))
              end
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
          raise e
          logger.error "Error responding to image upload"
          logger.error e
          logger.error e.backtrace

          flash.now[:error] = "There was an error uploading image. Please try again or contact administrator. "
        end
      end
    end
  end

  def destroy
    respond_to do |wants|
      wants.js do
        @image = Image.find_by_id(params[:id])
        @imageable = @image.imageable if @image

        if @image.destroy
          flash.now[:notice] = "Image removed successfully."
        else
          flash.now[:error] = @image.errors.full_messages.to_sentence
        end

        @imageable.reload
      end
    end
  end

  def make_primary
    respond_to do |wants|
      wants.js do
        @image = Image.find_by_id(params[:id])
        @imageable = @image.imageable

        if @imageable.respond_to?(:images)
          @image.primary = true

          if @image.save
            flash.now[:notice] = "Changed primary image."
          else
            flash.now[:error] = @image.errors.full_messages.to_sentence
          end

          @imageable.reload
        end
      end
    end
  end

end
