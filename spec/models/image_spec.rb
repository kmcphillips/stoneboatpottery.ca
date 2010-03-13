require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Image do
  before(:each) do
    @piece = Piece.create!(:name => "big face", :description => "some big face sculpture")
    @image_multi = Image.create!(:image_file_name => "img.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => false, :imageable => @piece)
    @post = Post.create!(:title => "news", :body => "pie is delicious")
    @image_single = Image.create!(:image_file_name => "img.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => false, :imageable => @post)
  end


  describe "callbacks" do
    it "should set primary to false if this is the only image" do
      @image_single.update_attribute(:primary, true)
      @image_single.save!
      @image_single.primary?.should be_false
    end

    it "should make another primary on destroy" do
      
    end

  end

  after(:each) do
    Image.delete_all
  end
end
