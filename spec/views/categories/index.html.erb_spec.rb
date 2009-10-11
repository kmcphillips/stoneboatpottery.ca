require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/categories/index.html.erb" do
  before(:each) do
    assigns[:categories] = [
      stub_model(Category,
        :name => "value for name",
        :description => "value for description",
        :permalink => "value for permalink"
      ),
      stub_model(Category,
        :name => "value for name",
        :description => "value for description",
        :permalink => "value for permalink"
      )
    ]
  end

  it "renders a list of categories" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
    response.should have_tag("tr>td", "value for description".to_s, 2)
    response.should have_tag("tr>td", "value for permalink".to_s, 2)
  end
end
