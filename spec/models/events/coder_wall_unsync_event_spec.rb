require 'spec_helper'

describe "CoderWallProfileUnsyncEvent" do

  describe "unsync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "rookieone")
      @profile.coder_wall_profile = @coder_wall_profile
      @profile.save
      @coder_wall_profile.save

      event = CoderWallProfileUnsyncEvent.new(:coder_wall_profile => @coder_wall_profile, :profile => @profile)
      event.subject_class_name = "CoderWallProfile"
      event.subject_id = @coder_wall_profile.id
      event.profile = @profile

      event.save
      @profile = Profile.find(@profile.id)
    end

    it { @profile.score(:coder_points).should == 0 }
    it { @profile.coder_wall_profile.should == nil }
  end

end

