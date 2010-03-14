require File.dirname(__FILE__) + '/../spec_helper'

describe SystemPost do
  before(:each) do
    @p = SystemPost.create!(:title => "post", :body => "post body")
  end

  it "should know it is a system post" do
    @p.system?.should be_true
  end

end