require 'spec_helper'

describe ApplicationHelper, type: :helper do
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

  describe "#boolean_wrapper" do
    it "should render the span for true values" do
      helper.boolean_wrapper(true).should eq("<span class=\"boolean_true\">Yes</span>")
    end

    it "should render the span for false values" do
      helper.boolean_wrapper(false).should eq("<span class=\"boolean_false\">No</span>")
    end

    it "should not care if a non-boolean is passed in" do
      helper.boolean_wrapper("pie").should eq("<span class=\"boolean_true\">Yes</span>")
    end
  end

  describe "page title" do
    it "should build a default page title" do
      self.stub(:params).and_return(:controller => "pie")
      page_title.should == "Stoneboat Pottery"
    end

    it "should build a page title for your controller" do
      self.stub(:params).and_return(:controller => "pie")
      self.instance_variable_set('@title', "Delicious")
      page_title.should == "Stoneboat Pottery - Delicious"
    end

    it "should show default admin" do
      self.stub(:params).and_return(:controller => "admin/pie")
      page_title.should == "Stoneboat Pottery - Admin"
    end

    it "should prepend admin if you are under admin" do
      self.stub(:params).and_return(:controller => "admin/pie")
      self.instance_variable_set('@title', "Delicious")
      page_title.should == "Stoneboat Pottery - Admin - Delicious"
    end

    it "should makes special exception for the blocks controller" do
      self.stub(:params).and_return(:controller => "blocks", :action => "eat")
      page_title.should == "Stoneboat Pottery - Eat"
    end

    it "should do the same for blocks controller under admin" do
      self.stub(:params).and_return(:controller => "admin/blocks", :action => "eat")
      page_title.should == "Stoneboat Pottery - Admin - Eat"
    end
  end
end
