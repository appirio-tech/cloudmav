require 'spec_helper'

describe "CoderWallProfileSyncEvent" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "rookieone")
      @profile.coder_wall_profile = @coder_wall_profile
      @coder_wall_profile.save
      event = CoderWallProfileSyncEvent.new(:coder_wall_profile => @coder_wall_profile, :profile => @profile)

      VCR.use_cassette("coder_wall_sync_event", :record => :new_episodes) do
        event.sync
      end
      @profile = Profile.find(@profile.id)
    end

    it { @coder_wall_profile.url.should == "http://www.coderwall.com/rookieone" }
    it { @coder_wall_profile.badges_count.should == 8 }
    it { @profile.score(:coder_points).should == 10 }
  end

  describe "scottburton 11 sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @coder_wall_profile = CoderWallProfile.new(:username => "scottburton11")
      @profile.coder_wall_profile = @coder_wall_profile
      @coder_wall_profile.save
      event = CoderWallProfileSyncEvent.new(:coder_wall_profile => @coder_wall_profile, :profile => @profile)

      VCR.use_cassette("coder_wall_scottburton11_sync_event", :record => :new_episodes) do
        event.sync
      end
      @profile = Profile.find(@profile.id)
    end

    it { @coder_wall_profile.url.should == nil }
    it { @coder_wall_profile.badges_count.should == 0 }
    it { @profile.score(:coder_points).should == 10 }
  end

end



