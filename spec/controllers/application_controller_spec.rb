require 'spec_helper'

describe ApplicationController, type: :controller do

  describe "load sidebar images" do
    it "should set the images from the named scope" do
      images = double
      Image.should_receive(:recent).with(an_instance_of(Fixnum)).and_return(images)
      controller.send(:load_sidebar_images)
    end
  end

end
