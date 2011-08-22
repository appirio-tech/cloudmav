require 'spec_helper'

describe "TwitterProfileSyncEvent" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @twitter_profile = TwitterProfile.new(:username => "rookieone")
      @profile.twitter_profile = @twitter_profile
      @twitter_profile.save
      event = TwitterProfileSyncEvent.new(:profile => @profile, :twitter_profile => @twitter_profile)

      VCR.use_cassette("twitter_sync_event", :record => :all) do
        event.sync
      end
    end

    it { @twitter_profile.url.should == "http://www.twitter.com/rookieone" }
    it { @twitter_profile.followers_count.should > 0 }
  end

end

