require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Category do
  before(:each) do
    @c = Category.create!(:name => "bowls and plates", :description => "bowls and plates are for eating!", :permalink => "bowls_and_mugs")
    @s = Subcategory.create!(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls", :category => @c)
  end

  it "should have subcategories" do
    @c.subcategories.should == [@s]
  end

  describe "active_subcategories" do
    it "should find all active subcategories in this category" do
      @c.subcategories.should_receive(:find).with(:all, :conditions => ["active = ?", true]).and_return([@s])
      @c.active_subcategories.should == [@s]
    end
  end
  
  after(:each) do
    Subcategory.delete_all
    Category.delete_all
  end
end
