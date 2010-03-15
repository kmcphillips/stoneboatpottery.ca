require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  describe "current user" do
    before(:each) do
      @u = mock_model(User)
    end

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
    before(:each) do
      self.stub!(:current_user).and_return(nil)
    end

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
      pending
    end

    it "should build a page title for your controller" do
      pending
    end

    it "should prepend admin if you are under admin" do
      pending
    end

    it "should makes special exception for the blocks controller" do
      pending
    end

    it "should do the same for blocks controller under admin" do
      pending
    end
  end


end
