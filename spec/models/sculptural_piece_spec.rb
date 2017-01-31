require 'spec_helper'

describe SculpturalPiece do

  describe "display_type" do
    it "should be correct for singular" do
      SculpturalPiece.new.display_type.should == "sculptural piece"
    end

    it "should be correct for plural" do
      SculpturalPiece.new.display_type(true).should == "sculptural pieces"
    end
  end
end
