require 'spec_helper'

describe Block do
  describe "#label_display" do
    it "should humanize the label" do
      Block.new(label: "pie is sweet").label_display.should eq("pie is sweet".humanize)
    end

    it "should have some saved defaults" do
      Block.new(label: "about_stoneboat").label_display.should eq("About Stoneboat")
      Block.new(label: "about_joanna").label_display.should eq("About JoAnna")
    end
  end

  describe "class method" do
    describe "#method_missing" do
      it "should find the block by label if it exists" do
        block = Block.create! label: "pie"  # Should be using factories.
        Block.pie.should eq(block)
      end

      it "should raise as expected if it does not find it" do
        lambda{ Block.pie }.should raise_error(NameError)
      end

      after(:each) do
        Block.destroy_all
      end
    end
  end
end
