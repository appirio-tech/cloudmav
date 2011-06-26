require 'spec_helper'

describe "GitHubProfileSyncEvent" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "rookieone")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
      event = GitHubProfileSyncEvent.new(:git_hub_profile => @git_hub_profile)

      VCR.use_cassette("git_hub_sync_event", :record => :new_episodes) do
        event.sync
      end
    end

    it { @git_hub_profile.url.should == "http://www.github.com/rookieone" }
    it { @git_hub_profile.git_hub_id.should_not be_empty }
    it { @git_hub_profile.followers_count.should == "8" }
    it { @git_hub_profile.following_count.should == "4" }

  end

end

