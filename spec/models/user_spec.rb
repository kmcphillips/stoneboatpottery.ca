require 'spec_helper'

describe User do
  before(:each) do
    @u = User.new(:username => "km", :password_hash => "1234567890abcdef")
  end

  it "should create a new instance" do
    @u.save.should be_truthy
  end

  it "should fail to create without a username" do
    u = User.new(:password_hash => "1234567890abcdef")
    u.save.should be_falsey
  end

  it "should fail to create without a password_hash" do
    u = User.new(:username => "km")
    u.save.should be_falsey
  end

  describe "authenticate" do
    before(:each) do
      User.stub(:encrypt).with("pie").and_return("pie_encrypted")
    end

    it "should find a user by name and password_hash" do
      User.should_receive(:where).with(["username = ? AND password_hash = ?", "km", "pie_encrypted"]).and_return([@u])
      User.authenticate("km", "pie").should == @u
    end

    it "should not find a user because of invalid username or password" do
      User.should_receive(:where).with(["username = ? AND password_hash = ?", "km", "pie_encrypted"]).and_return([])
      User.authenticate("km", "pie").should == nil
    end
  end

  describe "encrypt" do
    it "should encrypt the password into a hash" do
      Digest::SHA1.should_receive(:hexdigest).with("pie").and_return("delicious")
      User.encrypt("pie").should == "delicious"
    end
  end

  after(:each) do
    User.delete_all
  end
end
