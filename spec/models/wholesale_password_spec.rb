require 'spec_helper'

describe WholesalePassword do
  before(:each) do
    @valid_attributes = {
      :password => "value for password",
      :active => false,
      :expires_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    WholesalePassword.create!(@valid_attributes)
  end
end
