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

  describe "count forms" do
    before(:each) do
      @s2 = Subcategory.create!(:name => "plates", :description => "plates for eating", :permalink => "plates", :category => @c)
      Form.create!(:name => "f1", :description => "f1 description", :permalink => "f1_perm", :subcategory => @s)
      Form.create!(:name => "f2", :description => "f2 description", :permalink => "f2_perm", :subcategory => @s)
      Form.create!(:name => "f3", :description => "f3 description", :permalink => "f3_perm", :subcategory => @s2)
    end

    it "should count forms" do
      @c.count_forms.should == 3
    end
  end
  
  after(:each) do
    Subcategory.delete_all
    Category.delete_all
  end
end
