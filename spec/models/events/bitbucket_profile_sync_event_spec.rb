require 'spec_helper'

describe "BitbucketProfileSyncEvent" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @bitbucket_profile = BitbucketProfile.new(:username => "rookieone")
      @profile.bitbucket_profile = @bitbucket_profile
      @bitbucket_profile.save
      @bitbucket_profile.expects(:retag!)
      event = BitbucketProfileSyncEvent.new(:bitbucket_profile => @bitbucket_profile, :profile => @profile)

      VCR.use_cassette("bitbucket_sync_event", :record => :new_episodes) do
        event.sync
      end
      @profile = Profile.find(@profile.id)
    end

    it { @bitbucket_profile.url.should == "http://www.bitbucket.org/rookieone" }
    it { @bitbucket_profile.username.should_not be_empty }
    it { @bitbucket_profile.repository_count.should == "1" }
    it { @bitbucket_profile.followers_count.should == "1" }
    it { @profile.score(:coder_points).should == 10 }
  end

  describe "scottburton 11 sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @bitbucket_profile = BitbucketProfile.new(:username => "scottburton11")
      @profile.bitbucket_profile = @bitbucket_profile
      @bitbucket_profile.save
      @bitbucket_profile.expects(:retag!)
      event = BitbucketProfileSyncEvent.new(:bitbucket_profile => @bitbucket_profile, :profile => @profile)

      VCR.use_cassette("bitbucket_scottburton11_sync_event", :record => :new_episodes) do
        event.sync
      end
      @profile = Profile.find(@profile.id)
    end

    it { @bitbucket_profile.url.should == "http://www.bitbucket.org/scottburton11" }
    it { @bitbucket_profile.username.should_not be_empty }
    it { @bitbucket_profile.repository_count.should == "0" }
    it { @bitbucket_profile.followers_count.should == "0" }
    it { @profile.score(:coder_points).should == 10 }
  end

end


