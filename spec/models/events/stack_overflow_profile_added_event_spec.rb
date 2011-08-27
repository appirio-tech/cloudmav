require 'spec_helper'

describe "StackOverflowProfileAddedEvent" do

  describe "perform" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 29407)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save

      event = StackOverflowProfileAddedEvent.new(:stack_overflow_profile => @so_profile, :profile => @profile)
      event.subject_class_name = "StackOverflowProfile"
      event.subject_id = @so_profile.id
      event.profile = @profile
      event.perform

      @profile.reload
    end

    it { @profile.score(:knowledge_points).should > 0 }
  end

end

