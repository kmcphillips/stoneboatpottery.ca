require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WholesalePassword do

  describe "usable?" do
    before(:each) do
      @time_early = Time.now
      @time_late = Time.now
    end

    it "should not be usable if active is false" do
      WholesalePassword.new(:active => false).usable?.should be_false
    end

    it "should not be usable if date is earlier than now" do
      Time.stub!(:now).and_return(@time_late)
      WholesalePassword.new(:expires_at => @time_early).usable?.should be_false
    end

    it "should be usable if it is active and date is nil" do
      WholesalePassword.new.usable?.should be_true
    end

    it "should be usable if it is active and date is later than now" do
      Time.stub!(:now).and_return(@time_early)
      WholesalePassword.new(:expires_at => @time_late).usable?.should be_true
    end
  end

  describe "password_characters" do
    it "should not validate with special characters in the password" do
      wp = WholesalePassword.new(:password => "!^@*")
      wp.save.should be_false
    end

    it "should not validate if it is blank" do
      wp = WholesalePassword.new(:password => "")
      wp.save.should be_false
    end

    it "should validate with letters, numbers, dashes, and underscores" do
      wp = WholesalePassword.new(:password => "abc_REW-342")
      wp.save.should be_true
    end

    after(:each) do
      WholesalePassword.delete_all
    end
  end
end
