require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Link do

  describe "url_begins_with_protocol" do
    it "should fail without the protocol on the URL" do
      l = Link.new(:url => "pie")
      l.save.should be_false
    end

    it "should save with an http:// URL" do
      l = Link.new(:url => "http://pie")
      l.save.should be_true
    end

    it "should save with an https:// URL" do
      l = Link.new(:url => "https://pie")
      l.save.should be_true
    end

    after(:each) do
      Link.delete_all
    end
  end
end
