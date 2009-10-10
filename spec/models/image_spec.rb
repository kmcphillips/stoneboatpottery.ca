require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  before(:each) do
    @valid_attributes = {
      :path => "value for path",
      :primary => false,
      :imageable_id => 1,
      :imageable_type => "value for imageable_type"
    }
  end

  it "should create a new instance given valid attributes" do
    Image.create!(@valid_attributes)
  end
  
  after(:each) do
    Image.delete_all
  end
end
