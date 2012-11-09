require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::SessionsController do
  before(:each) do
    @u = mock_model(User)
    controller.stub!(:require_login)
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

  describe "GET password" do
    it "should render view" do
      get :password
      response.should render_template("admin/sessions/password")
    end
  end

  describe "POST change_password" do
    before(:each) do
      controller.stub!(:current_user).and_return(@u)
      @u.stub!(:change_password!).and_return(true)
      controller.stub!(:require_login)
    end

    it "should redirect" do
      @u.stub!(:save).and_return(true)
      post :change_password
      response.should redirect_to(password_admin_sessions_path)
    end

    it "should change password with params" do
      @u.should_receive(:change_password!).with("pass1", "pass2").and_return(true)
      post :change_password, :password => "pass1", :password_confirm => "pass2"
    end

    it "should flash errors on failure" do
      @u.should_receive(:change_password!).and_return(false)
      @u.should_receive(:errors).and_return(mock("errors", :full_messages => ["delicious", "pie"]))
      post :change_password
      flash[:error].should == "delicious and pie"
    end
  end

  it "should know which controllers need authentication" do
    controller.send(:require_login_except).sort.should == ["index", "new", "create", "destroy", "logout"].sort
  end
end
