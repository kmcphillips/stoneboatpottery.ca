require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Form do
  before(:each) do
    @c = Category.create!(:name => "bowls and plates", :description => "bowls and plates are for eating!", :permalink => "bowls_and_mugs", :active => true)
    @s = Subcategory.create!(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls", :category => @c, :active => true)
    @f = Form.create!(:name => "soup bowl", :description => "for soup", :subcategory => @s, :active => true)
  end

  it "should have a parent subcategory" do
    @f.subcategory.should == @s
  end

  it "should fail to save if it does not have a subcategory" do
    s = Form.new(:name => "bowls", :description => "bowls for soup and salad")
    s.save.should be_false
  end

  describe "inherited active" do
    it "should be false if it is inactive" do
      @f.update_attribute(:active, false)
      @f.inherited_active?.should be_false
    end

    it "should be false if the category is inactive" do
      @s.should_receive(:inherited_active?).and_return(false)
      @f.inherited_active?.should be_false
    end

    it "should be true of everything is active" do
      @f.inherited_active?.should be_true
    end
  end

  describe "deactivate!" do
    it "should description" do
      @f.deactivate!
      @f.active?.should be_false
    end
  end

  after(:each) do
    Form.delete_all
    Subcategory.delete_all
    Category.delete_all
  end
end
