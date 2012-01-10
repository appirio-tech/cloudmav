require 'spec_helper'

describe "ProfileActivityPresenter - GitHub Activity" do
  before(:each) do
    profile = Profile.new
    profile.git_hub_profile = GitHubProfile.new(:username => "rookieone")
    
    VCR.use_cassette("git_hub_activity", :record => :new_episodes) do
      @activity = ProfileActivityPresenter.get_activity(profile)
    end
    puts @activity.inspect
  end
  
  it { @activity.should_not be_nil }
end