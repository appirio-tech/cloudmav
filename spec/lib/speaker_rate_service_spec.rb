require 'spec_helper'

describe SpeakerRateService do
  
  describe "synch" do
    before(:each) do
      @profile = SpeakerRateProfile.new(:speaker_rate_id => 10082)
      SpeakerRateService.synch(@profile)
    end
    
    it { @profile.url.should_not be_nil }
    it { @profile.rating.should_not be_nil }
  end
  
end