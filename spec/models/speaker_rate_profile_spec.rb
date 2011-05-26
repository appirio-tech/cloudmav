require 'spec_helper'

describe SpeakerRateProfile do
  
  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @speaker_rate_profile = SpeakerRateProfile.create(:speaker_rate_id => 10082, :profile => @profile)
      VCR.use_cassette("speaker_rate", :record => :new_episodes) do
        @speaker_rate_profile.sync!
      end
    end
    
    it { @speaker_rate_profile.url.should_not be_nil }
    it { @speaker_rate_profile.rating.should_not be_nil }
    it { @profile.talks.should_not be_empty }
  end
  
end
