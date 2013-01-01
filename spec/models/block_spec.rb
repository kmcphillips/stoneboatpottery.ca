require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Block do
  describe "#label_display" do
    it "should humanize the label" do
      Block.new(:label => "pie is sweet").label_display.should == "pie is sweet".humanize
    end

    it "should have some saved defaults" do
      Block.new(:label => "about_stoneboat").label_display.should == "About Stoneboat"
      Block.new(:label => "about_joanna").label_display.should == "About JoAnna"
    end
  end
end
