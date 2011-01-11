require 'spec_helper'

describe StackOverflowProfile do
  
  describe "synch" do
    before(:each) do
      @profile = Profile.new
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 60336)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.synch!
    end
    
    it { @so_profile.reputation.should > 0 }
    
  end
  
end