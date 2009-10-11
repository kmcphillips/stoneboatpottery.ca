require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Subcategory do
  before(:each) do
    @c = Category.create!(:name => "bowls and plates", :description => "bowls and plates are for eating!", :permalink => "bowls_and_mugs")
    @s = Subcategory.create!(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls", :category => @c)
  end

  it "should have a parent category" do
    @s.category.should == @c
  end
  
  it "should fail to save if it does not have a category" do
    s = Subcategory.new(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls")
    s.save.should be_false
  end
  
  after(:each) do
    Subcategory.delete_all
    Category.delete_all
  end
end