require 'spec_helper'

describe BitBucketService do
  
  describe "synch" do
    before(:each) do
      @profile = BitBucketProfile.new(:username => "rookieone")
      BitBucketService.synch(@profile)
    end
    
    it { @profile.url.should_not be_nil }
    it { @profile.followers_count.should_not be_nil }
    it { @profile.repositories_count.should_not be_nil }
  end
  
end