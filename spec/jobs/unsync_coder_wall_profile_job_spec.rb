require 'spec_helper'

describe "UnsyncCoderWallProfileJob" do

  describe "unsync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "rookieone")
      @profile.coder_wall_profile = @coder_wall_profile
      @profile.save
      @coder_wall_profile.save
      
      UnsyncCoderWallProfileJob.perform(@coder_wall_profile.id)
      @profile = Profile.find(@profile.id)
    end

    it { @profile.score(:coder_points).should == 0 }
    it { @profile.coder_wall_profile.should == nil }
  end

end