require 'spec_helper'

describe SlideShareProfile do
  
  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile 
      @slide_share_profile = SlideShareProfile.create(:slide_share_username => "rookieone", :profile => @profile)
      VCR.use_cassette("slide_share", :record => :new_episodes) do
        @slide_share_profile.sync!
      end
    end
    
    it { @slide_share_profile.url.should_not be_nil }
    it { @profile.talks.should_not be_empty }
    it "should set the thumbnail" do
      @profile.talks.each {|t| t.slide_share_thumbnail.should_not be_nil }
    end
  end
  
end
