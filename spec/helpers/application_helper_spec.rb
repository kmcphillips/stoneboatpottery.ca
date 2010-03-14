require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ApplicationHelper do
  describe "current user" do
    before(:each) do
      @u = mock_model(User)
    end

    it "should find the current user if you are logged in" do
      pending
    end

    it "should not look for a user if none is stored " do
      pending
    end
  end

  describe "wholesale" do
    it "should let you into wholesale if you are logged in as a site user" do
      pending
    end

    it "should let you in if you are logged into the wholesale area" do
      pending
    end

    it "should not let you in otherwise" do
      pending
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
