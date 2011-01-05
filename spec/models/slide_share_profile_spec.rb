require 'spec_helper'

describe SlideShareProfile do
  
  describe "sync" do
    before(:each) do
      @profile = Factory.create(:profile) 
      @slide_share_profile = SlideShareProfile.new(:slide_share_username => "rookieone")
      @profile.slide_share_profile = @slide_share_profile
      @profile.save!
      @slide_share_profile.sync!
    end
    
    it { @slide_share_profile.url.should_not be_nil }
    it { @profile.talks.should_not be_empty }
  end
  
end