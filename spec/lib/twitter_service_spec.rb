require 'spec_helper'

describe TwitterService do
  
  describe "synch" do
    before(:each) do
      @profile = TwitterProfile.new
      @profile.username = "rookieone"
      TwitterService.synch(@profile)
    end
    
    it { @profile.followers_count.should > 0 }
  end
  
end