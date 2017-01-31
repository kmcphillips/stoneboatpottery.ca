require 'spec_helper'

describe Link do

  describe "url_begins_with_protocol" do
    it "should fail without the protocol on the URL" do
      l = Link.new(:url => "pie")
      l.save.should be_falsey
    end

    it "should save with an http:// URL" do
      l = Link.new(:url => "http://pie")
      l.save.should be_truthy
    end

    it "should save with an https:// URL" do
      l = Link.new(:url => "https://pie")
      l.save.should be_truthy
    end

    after(:each) do
      Link.delete_all
    end
  end
end
