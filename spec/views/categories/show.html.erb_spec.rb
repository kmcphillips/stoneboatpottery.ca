require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/show.html.erb" do
  before(:each) do
    assigns[:category] = @category = stub_model(Category,
      :name => "value for name",
      :description => "value for description",
      :permalink => "value for permalink"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
    response.should have_text(/value\ for\ description/)
    response.should have_text(/value\ for\ permalink/)
  end
end
