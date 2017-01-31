require 'spec_helper'

describe FunctionalPiece do

  describe "display_type" do
    it "should be correct for singular" do
      FunctionalPiece.new.display_type.should == "funky functional piece"
    end

    it "should be correct for plural" do
      FunctionalPiece.new.display_type(true).should == "funky functional pieces"
    end
  end
end
