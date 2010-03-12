require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Block do
  it "should make the label shiny" do
    Block.new(:label => "pie").label_display.should == "pie".humanize
  end
end
