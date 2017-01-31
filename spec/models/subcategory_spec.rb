require 'spec_helper'

describe Subcategory do
  before(:each) do
    @c = Category.create!(:name => "bowls and plates", :description => "bowls and plates are for eating!", :permalink => "bowls_and_mugs", :active => true)
    @s = Subcategory.create!(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls", :category => @c, :active => true)
    @f = Form.create!(:name => "bowl", :description => "a bowl", :subcategory => @s, :active => true)
  end

  it "should have a parent category" do
    @s.category.should == @c
  end

  it "should fail to save if it does not have a category" do
    s = Subcategory.new(:name => "bowls", :description => "bowls for soup and salad", :permalink => "bowls")
    s.save.should be_falsey
  end

  describe "inherited active" do
    it "should be false if it is inactive" do
      @s.update_attribute(:active, false)
      @s.inherited_active?.should be_falsey
    end

    it "should be false if the category is inactive" do
      @c.should_receive(:inherited_active?).and_return(false)
      @s.inherited_active?.should be_falsey
    end

    it "should be true of everything is active" do
      @s.inherited_active?.should be_truthy
    end
  end

  describe "deactivate!" do
    it "should update its own status" do
      @s.deactivate!
      @s.active?.should be_falsey
    end

    it "should update all of its children" do
      @s.deactivate!
      @s.forms.any?{|f| f.active? }.should be_falsey
    end

    it "should not do anything if it is already inactive" do
      @s.update_attribute(:active, false)
      @s.should_not_receive(:update_attribute)
      @f.should_not_receive(:deactivate!)
      @s.deactivate!
    end
  end

  describe "deactivate children" do
    it "should make all the children inactive" do
      @s.active = false
      @s.save!
      @s.forms.any?{|f| f.active? }.should be_falsey
    end
  end

  after(:each) do
    Subcategory.delete_all
    Category.delete_all
  end
end
