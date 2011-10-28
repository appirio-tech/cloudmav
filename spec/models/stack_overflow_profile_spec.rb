require 'spec_helper'

describe StackOverflowProfile do
  
  describe "synch" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.create(:stack_overflow_id => 60336, :profile => @profile)
      VCR.use_cassette("stack_overflow", :record => :all) do
        @so_profile.sync!
      end
      @so_profile.reload
      @profile.reload
    end
    
    it { @so_profile.reputation.should > 0 }
    it { @so_profile.taggings.count.should > 0 }
    it "should earn knowledge points" do
      expected_points = 10 + @so_profile.reputation / 100 
      @profile.score(:knowledge_points).should == expected_points
    end
  end
  
end
