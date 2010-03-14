require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Post do
  before(:each) do
    @p = Post.create!(:title => "post", :body => "post body")
  end

  it "should know it is not a system post" do
    @p.system?.should be_false
  end
end
