require 'spec_helper'

describe "SyncGitHubProfileJob" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "rookieone")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
  
      VCR.use_cassette("git_hub_sync_event", :record => :new_episodes) do
        SyncGitHubProfileJob.perform(@git_hub_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @git_hub_profile.reload
    end
  
    it { @git_hub_profile.url.should == "http://www.github.com/rookieone" }
    it { @git_hub_profile.git_hub_id.should_not be_empty }
    it { @git_hub_profile.followers_count.should == 9 }
    it { @git_hub_profile.following_count.should == 4 }
    it { @profile.score(:coder_points).should == 54 }
  end
  
  describe "jnunemaker sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "jnunemaker")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
  
      VCR.use_cassette("jnunemaker git_hub_sync_event", :record => :new_episodes) do
        SyncGitHubProfileJob.perform(@git_hub_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @git_hub_profile.reload
    end
  
    it { @git_hub_profile.url.should == "http://www.github.com/jnunemaker" }
    it { @git_hub_profile.git_hub_id.should_not be_empty }
    it { @git_hub_profile.followers_count.should == 795 }
    it { @git_hub_profile.following_count.should == 23 }
    it { @git_hub_profile.repositories.count.should == 42 }
    it { @profile.score(:coder_points).should == 873 }
  end
   
  describe "chriseppstein sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "chriseppstein")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
  
      VCR.use_cassette("chriseppstein git_hub_sync_event", :record => :new_episodes) do
        SyncGitHubProfileJob.perform(@git_hub_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @git_hub_profile.reload
    end
  
    it { @git_hub_profile.url.should == "http://www.github.com/chriseppstein" }
    it { @git_hub_profile.git_hub_id.should_not be_empty }
    it { @git_hub_profile.followers_count.should == 354 }
    it { @git_hub_profile.following_count.should == 25 }
    it { @git_hub_profile.repositories.count.should == 26 }
    it { @profile.score(:coder_points).should == 455 }
  end
  
  describe "Dennis Traub sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "Dennis Traub")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
  
      VCR.use_cassette("Dennis Traub git_hub_sync_event", :record => :new_episodes) do
        SyncGitHubProfileJob.perform(@git_hub_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @git_hub_profile.reload
    end
  
    it { @git_hub_profile.url.should == "http://www.github.com/DennisTraub" }
    it { @git_hub_profile.git_hub_id.should_not be_empty }
  end
  
  describe "bad username sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @git_hub_profile = GitHubProfile.new(:username => "euwberwubrepobnreopibnqerpou")
      @profile.git_hub_profile = @git_hub_profile
      @git_hub_profile.save
      @git_hub_profile.expects(:retag!)
  
      VCR.use_cassette("git_hub_sync_event_bad_username", :record => :new_episodes) do
        SyncGitHubProfileJob.perform(@git_hub_profile.id)
      end
      @profile = Profile.find(@profile.id)
      @git_hub_profile.reload
    end
  
    it { @git_hub_profile.error_message.should == "User not found" }
  end  
end