require 'spec_helper'

describe "SyncCoderWallProfileJob" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "rookieone")
      @profile.coder_wall_profile = @coder_wall_profile
      @coder_wall_profile.save

      VCR.use_cassette("coder_wall_sync_event", :record => :new_episodes) do
        SyncCoderWallProfileJob.perform(@coder_wall_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @coder_wall_profile.reload
    end

    it { @coder_wall_profile.url.should == "http://www.coderwall.com/rookieone" }
    it { @coder_wall_profile.badges_count.should == 8 }
    it { @profile.score(:coder_points).should > 0 }
  end

  describe "scottburton 11 sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "scottburton11")
      @profile.coder_wall_profile = @coder_wall_profile
      @coder_wall_profile.save
  
      VCR.use_cassette("coder_wall_scottburton11_sync_event", :record => :new_episodes) do
        SyncCoderWallProfileJob.perform(@coder_wall_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @coder_wall_profile.reload
    end
  
    it { @coder_wall_profile.url.should == nil }
    it { @coder_wall_profile.badges_count.should == 0 }
    it { @profile.score(:coder_points).should == 0 }
  end

end



