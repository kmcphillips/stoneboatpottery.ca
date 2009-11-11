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
            @image = Image.new(params[:image])
            @imageable = params[:imageable_type].constantize.find(params[:imageable_id]) rescue nil

            if @image.save
              begin
                if @imageable.respond_to?(:image)
                  @imageable.image.andand.destroy   # This puts exceptions in the logs but works so i'm just going to leave it as is
                  @imageable.image = @image
                elsif @imageable.respond_to?(:images)
                  @imageable.images << @image
                else
                  raise StandardError, "does not respond to image or images"
                end

                flash.now[:notice] = 'Image successfully added.'
              rescue => e
                flash.now[:error] = 'Unable to associate image to object. Contact administrator.'
                # TODO log this exception
              end
            else
              flash.now[:error] = @image.errors.full_messages.to_sentence
            end
          rescue => e
            # TODO log e
            flash.now[:error] = "There was an error uploading image. Please try again or contact administrator."
          end

          render :update do |page|
            page.call "upload_after"
            page.replace :image_container, :partial => "shared/image_single", :locals => {:imageable => @imageable} if @imageable.andand.respond_to?(:image)
            page.replace :images_container, :partial => "shared/image_multiple", :locals => {:imageable => @imageable} if @imageable.andand.respond_to?(:images)
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
            # TODO log weird error here
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
          @image.make_primary
          flash.now[:notice] = "Changed primary image."

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
