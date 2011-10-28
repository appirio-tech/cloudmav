require 'spec_helper'

describe "SyncTwitterProfileJob" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @twitter_profile = TwitterProfile.new(:username => "rookieone")
      @profile.twitter_profile = @twitter_profile
      @twitter_profile.save

      VCR.use_cassette("twitter_sync_event", :record => :all) do
        SyncTwitterProfileJob.perform(@twitter_profile.id)
      end
      @twitter_profile.reload
    end

    it { @twitter_profile.url.should == "http://www.twitter.com/rookieone" }
    it { @twitter_profile.followers_count.should > 0 }
  end

end