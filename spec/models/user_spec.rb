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
end
