require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Piece do
  before(:each) do
    @p = Piece.new(:name => "weirdy face", :description => "some big weirdy face sculpture")
  end

  

  after(:each) do
    Piece.delete_all
  end
end
