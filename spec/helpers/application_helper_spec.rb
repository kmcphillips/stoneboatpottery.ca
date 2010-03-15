require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include ApplicationHelper

describe ApplicationHelper do
  before(:each) do
    @u = mock_model(User)
  end

  describe "current user" do
    it "should find the current user if you are logged in" do
      session[:admin_user] = "pie"
      User.should_receive(:find).with("pie").and_return(@u)
      current_user.should == @u
    end

    it "should not look for a user if none is stored " do
      User.should_not_receive(:find)
      current_user.should be_nil
    end
  end

  describe "wholesale" do
    it "should let you into wholesale if you are logged in as a site user" do
      self.stub!(:current_user).and_return(@u)
      wholesale?.should == true
    end

    it "should let you in if you are logged into the wholesale area" do
      session[:wholesale_permitted] = true
      wholesale?.should == true
    end

    it "should not let you in otherwise" do
      wholesale?.should == false
    end
  end

  describe "page title" do
    it "should build a default page title" do
      self.stub!(:params).and_return(:controller => "pie")
      page_title.should == "Stoneboat Pottery"
    end

    it "should build a page title for your controller" do
      self.stub!(:params).and_return(:controller => "pie")
      self.instance_variable_set('@title', "Delicious")
      page_title.should == "Stoneboat Pottery - Delicious"
    end

    it "should show default admin" do
      self.stub!(:params).and_return(:controller => "admin/pie")
      page_title.should == "Stoneboat Pottery - Admin"
    end
    
    it "should prepend admin if you are under admin" do
      self.stub!(:params).and_return(:controller => "admin/pie")
      self.instance_variable_set('@title', "Delicious")
      page_title.should == "Stoneboat Pottery - Admin - Delicious"
    end
    
    it "should makes special exception for the blocks controller" do
      self.stub!(:params).and_return(:controller => "blocks", :action => "eat")
      page_title.should == "Stoneboat Pottery - Eat"
    end

    it "should do the same for blocks controller under admin" do
      self.stub!(:params).and_return(:controller => "admin/blocks", :action => "eat")
      page_title.should == "Stoneboat Pottery - Admin - Eat"
    end
  end

  describe "other helpers" do
    it "should be tested" do
      pending
    end
  end
end
