require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationController do

  describe "load sidebar images" do
    it "should set the images from the named scope" do
      images = mock
      Image.should_receive(:recent).with(an_instance_of(Fixnum)).and_return(images)
      controller.send(:load_sidebar_images)
    end
  end
  
  describe "require login" do
    it "should kick you out if you are not logged in" do
      controller.should_receive(:redirect_to).with(an_instance_of(String))
      controller.require_login
    end
    
    it "should do nothing if you are logged in" do
      session[:admin_user] = mock
      controller.should_not_receive(:redirect_to)
      controller.require_login
    end
    
    it "should handle lists of exception actions" do
      controller.stub!(:require_login_except).and_return([:index])
      controller.stub!(:params).and_return(:action => :index)
      controller.should_not_receive(:redirect_to)
      controller.require_login
    end
  end
end
