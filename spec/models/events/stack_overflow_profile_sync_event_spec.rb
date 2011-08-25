require 'spec_helper'

describe "StackOverflowProfileSyncEvent" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 29407)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      event = StackOverflowProfileSyncEvent.new(:stack_overflow_profile => @so_profile, :profile => @profile)
      event.subject_class_name = "StackOverflowProfile"
      event.subject_id = @so_profile.id
      event.profile = @profile

      VCR.use_cassette("stack_overflow_sync_event", :record => :all) do
        event.perform
      end
      @profile.reload
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/29407" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should == 3 }
    it { @so_profile.answers.count.should == 3 }
  end

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 60336)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      event = StackOverflowProfileSyncEvent.new(:stack_overflow_profile => @so_profile)
      event.subject_class_name = "StackOverflowProfile"
      event.subject_id = @so_profile.id
      event.profile = @profile

      VCR.use_cassette("stack_overflow_sync_again_event", :record => :all) do
        event.perform
        @question_count = @so_profile.questions.count
        @answer_count = @so_profile.answers.count
        event.perform
      end
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/60336" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should == @question_count }
    it { @so_profile.answers.count.should == @answer_count }
  end

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 5056)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      event = StackOverflowProfileSyncEvent.new(:stack_overflow_profile => @so_profile)
      event.subject_class_name = "StackOverflowProfile"
      event.subject_id = @so_profile.id
      event.profile = @profile

      VCR.use_cassette("stack_overflow_sync_again_event", :record => :all) do
        event.perform
        @question_count = @so_profile.questions.count
        @answer_count = @so_profile.answers.count
        event.perform
      end
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/5056" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should == @question_count }
    it { @so_profile.answers.count.should == @answer_count }
  end


  
end
