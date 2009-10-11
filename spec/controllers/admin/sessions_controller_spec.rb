require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::SessionsController do
  before(:each) do
    @u = mock_model(User)
  end

  describe "GET index" do
    it "should redirect to new action" do
      get :index
      response.should redirect_to("/admin/login")
    end
  end

  describe "GET new" do
    it "should render the default view" do
      get :new
      response.should render_template("admin/sessions/new")
    end
  end
  
  describe "POST create" do
    describe "success" do
      before(:each) do
        User.should_receive(:authenticate).with("user", "pass").and_return(@u)
      end
      
      it "should log user in successfully and flash" do
        post :create, :username => "user", :password => "pass"
        flash[:notice].should == "Logged in successfully."
      end

      it "should log user in successfully and redirect" do
        post :create, :username => "user", :password => "pass"      
        response.should redirect_to(admin_posts_path)
      end
    end
    
    describe "failure" do
      before(:each) do
        User.should_receive(:authenticate).with("user", "pass").and_return(nil)
      end
      
      it "should flash a message" do
        post :create, :username => "user", :password => "pass"
        flash[:error].should == "Username and password are incorrect."
      end
      
      it "should render the same view" do
        post :create, :username => "user", :password => "pass"
        response.should redirect_to("/admin/login")
      end
    end
  end
  
  describe "DELETE destroy" do
    it "should redirec to the index" do
      pending
      delete :destroy
      response.should redirect_to("/")
    end
  end

  after(:each) do
    
  end
end
