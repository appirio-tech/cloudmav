require 'spec_helper'

describe SpeakerRateService do
  
  describe "sync" do
    before(:each) do
      @profile = Factory.create(:profile) 
      @speaker_rate_profile = SpeakerRateProfile.new(:speaker_rate_id => 10082)
      @profile.speaker_rate_profile = @speaker_rate_profile
      @profile.save!
      @speaker_rate_profile.sync!
    end
    
    it { @speaker_rate_profile.url.should_not be_nil }
    it { @speaker_rate_profile.rating.should_not be_nil }
    it { @profile.talks.should_not be_empty }
    it { @profile.presentations.should_not be_empty }
  end
  
end