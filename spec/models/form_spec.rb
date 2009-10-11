require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Form do
  before(:each) do
    @c = Category.create!(:name => "bowls and plates", :description => "bowls and plates are for eating!", :permalink => "bowls_and_mugs")
    @s = Subcategory.create!(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls", :category => @c)
    @f = Form.create!(:name => "soup bowl", :description => "for soup", :subcategory => @s)
  end

  it "should have a parent subcategory" do
    @f.subcategory.should == @s
  end
  
  it "should fail to save if it does not have a subcategory" do
    s = Form.new(:name => "bowls", :description => "bowls for soup and salad")
    s.save.should be_false
  end
  
  after(:each) do
    Form.delete_all
    Subcategory.delete_all
    Category.delete_all
  end
end
