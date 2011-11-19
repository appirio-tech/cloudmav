require 'spec_helper'

describe User do
  describe "setting username" do
    it "should lowercase username" do
      @user = Factory.build(:user)
      @user.username = "FOOBAR"
      @user.save
      @user.reload
      @user.username.should == "foobar"
    end
  end

  describe "no symbols" do
    it "should not be valid" do
      @user = Factory.build(:user)
      @user.username = "joe@example.com"
      @user.should_not be_valid
    end
  end

  describe "allow numbers" do
    it "should not be valid" do
      @user = Factory.build(:user)
      @user.username = "joe100"
      @user.should be_valid
    end
  end
  
  describe "username must be unique" do
    before(:each) do
      Factory.create(:user, :username => "someusername")
      @user = Factory.build(:user, :username => "someusername")
    end
    it { @user.should_not be_valid }
  end
end