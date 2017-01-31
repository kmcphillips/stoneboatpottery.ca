require 'spec_helper'

describe AuthenticatedController, type: :controller do

  describe "require login" do
    it "should kick you out if you are not logged in" do
      controller.should_receive(:redirect_to).with(an_instance_of(String))
      controller.send(:require_login)
    end

    it "should do nothing if you are logged in" do
      session[:admin_user] = double
      controller.should_not_receive(:redirect_to)
      controller.send(:require_login)
    end

    it "should handle lists of exception actions" do
      controller.stub(:require_login_except).and_return([:index])
      controller.stub(:params).and_return(:action => :index)
      controller.should_not_receive(:redirect_to)
      controller.send(:require_login)
    end
  end
end
