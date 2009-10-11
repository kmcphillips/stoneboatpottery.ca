require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CategoriesController do

  def mock_category(stubs={})
    @mock_category ||= mock_model(Category, stubs)
  end

  describe "GET index" do
    it "assigns all categories as @categories" do
      Category.stub!(:find).with(:all).and_return([mock_category])
      get :index
      assigns[:categories].should == [mock_category]
    end
  end

  describe "GET show" do
    it "assigns the requested category as @category" do
      Category.stub!(:find).with("37").and_return(mock_category)
      get :show, :id => "37"
      assigns[:category].should equal(mock_category)
    end
  end

end
