require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @u = User.new(:username => "km", :password => "1234567890abcdef")
  end

  it "should create a new instance" do
    @u.save.should be_true
  end
  
  it "should fail to create without a username" do
    u = User.new(:password => "1234567890abcdef")
    u.save.should be_false
  end
  
  it "should fail to create without a password" do
    u = User.new(:username => "km")
    u.save.should be_false
end
  
  describe "authenticate" do
    before(:each) do
      User.stub!(:encrypt).with("pie").and_return("pie_encrypted")
    end
    
    it "should find a user by name and password" do
      User.should_receive(:first).with(:conditions => ["username = ? AND password = ?", "km", "pie_encrypted"]).and_return(@u)
      User.authenticate("km", "pie").should == @u
    end
    
    it "should not find a user because of invalid username or password" do
      User.should_receive(:first).with(:conditions => ["username = ? AND password = ?", "km", "pie_encrypted"]).and_return(nil)
      User.authenticate("km", "pie").should == nil
    end
  end
  
  describe "encrypt" do
    it "should encrypt the password into a hash" do
      pending
    end
  end
  
  after(:each) do
    User.delete_all
  end
end
