require 'spec_helper'

describe StackOverflowProfile do
  
  describe "synch" do
    before(:each) do
      @profile = Factory.create(:profile)
      @so_profile = StackOverflowProfile.create(:stack_overflow_id => 60336, :profile => @profile)
      VCR.use_cassette("stack_overflow", :record => :new_episodes) do
        @so_profile.synch!
      end
    end
    
    it { @so_profile.reputation.should > 0 }
    it { @so_profile.taggings.count.should > 0 }
  end
  
end
