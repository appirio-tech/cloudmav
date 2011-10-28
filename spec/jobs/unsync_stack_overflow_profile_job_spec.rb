require 'spec_helper'

describe "UnsyncStackOverflowProfileJob" do

  describe "unsync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @stack_overflow_profile = StackOverflowProfile.new(:stack_overflow_id => "60336")
      @profile.stack_overflow_profile = @stack_overflow_profile
      @profile.save
      @stack_overflow_profile.save

      UnsyncStackOverflowProfileJob.perform(@stack_overflow_profile.id)
      @profile = Profile.find(@profile.id)
    end

    it { @profile.score(:knowledge_points).should == 0 }
    it { @profile.stack_overflow_profile.should == nil }
  end

end

