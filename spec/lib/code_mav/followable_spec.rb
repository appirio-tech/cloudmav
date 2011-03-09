require 'spec_helper'

describe "Followable" do

  describe "follow" do
    before(:each) do
      @follower = Factory.create(:user).profile
      @followee = Factory.create(:user).profile
      @follower.follow!(@followee)
    end

    it { @follower.follows?(@followee).should == true } 
    it { @follower.followees.include?(@followee).should == true }
    it { @followee.follower?(@follower).should == true }
    it { @followee.followers.include?(@follower).should == true }
  end

end
