require 'spec_helper'

describe Image do
  before(:each) do
    @piece = Piece.create!(:name => "big face", :description => "some big face sculpture")
    @img1 = Image.create!(:image_file_name => "img1.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => true, :imageable => @piece)
    @img2 = Image.create!(:image_file_name => "img2.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => false, :imageable => @piece)
    @img3 = Image.create!(:image_file_name => "img3.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => false, :imageable => @piece)

    @post = Post.create!(:title => "news", :body => "pie is delicious")
    @image_single = Image.create!(:image_file_name => "img.jpg", :image_content_type => "image/jpeg", :image_file_size => 100, :primary => false, :imageable => @post)
  end


  describe "callbacks" do
    it "should set primary to false if this is the only image" do
      @image_single.update_attribute(:primary, true)
      @image_single.save!
      @image_single.primary?.should be_falsey
    end

    it "should make another primary on destroy" do
      @img1.primary?.should be_truthy
      @img1.destroy
      @piece.images.first.primary?.should be_truthy
    end

    describe "manage primary" do
      it "should set all others to not be primary if one is made primary" do
        @img3.primary = true
        @img3.save!
        @img1.reload
        @img1.primary?.should be_falsey
      end

      it "should make the last remaining image primary if all others are destroyed" do
        @img3.destroy
        @img1.destroy
        @img2.reload
        @img2.primary?.should be_truthy
      end
    end
  end

  after(:each) do
    Image.delete_all
  end
end
