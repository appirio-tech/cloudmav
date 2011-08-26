require 'spec_helper'

describe "StackOverflowProfileUnsyncEvent" do

  describe "unsync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @stack_overflow_profile = StackOverflowProfile.new(:stack_overflow_id => "60336")
      @profile.stack_overflow_profile = @stack_overflow_profile
      @profile.save
      @stack_overflow_profile.save

      event = StackOverflowProfileUnsyncEvent.new(:stack_overflow_profile => @stack_overflow_profile, :profile => @profile)
      event.subject_class_name = "StackOverflowProfile"
      event.subject_id = @stack_overflow_profile.id
      event.profile = @profile

      event.save
      @profile = Profile.find(@profile.id)
    end

    it { @profile.score(:knowledge_points).should == 0 }
    it { @profile.stack_overflow_profile.should == nil }
  end

end

