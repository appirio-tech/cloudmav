require 'spec_helper'

describe "SyncStackOverflowProfileJob" do

  describe "sync" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 29407)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      VCR.use_cassette("stack_overflow_sync_event", :record => :all) do
        SyncStackOverflowProfileJob.perform(@so_profile.id)
      end
      @profile.reload
      @so_profile.reload
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/29407" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should == 3 }
    it { @so_profile.answers.count.should == 3 }
  end
  
  describe "sync 60336 again" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 60336)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      VCR.use_cassette("stack_overflow_sync_again_event", :record => :all) do
        SyncStackOverflowProfileJob.perform(@so_profile.id)
        @so_profile.reload
        @question_count = @so_profile.questions.count
        @answer_count = @so_profile.answers.count
        SyncStackOverflowProfileJob.perform(@so_profile.id)
      end
      @profile.reload
      @so_profile.reload
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/60336" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should == @question_count }
    it { @so_profile.answers.count.should == @answer_count }
  end
  
  describe "sync 5056" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 5056)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      VCR.use_cassette("stack_overflow_sync_again_event", :record => :all) do
        SyncStackOverflowProfileJob.perform(@so_profile.id)
      end
      @profile.reload
      @so_profile.reload
    end

    it { @profile.score(:knowledge_points).should == 10 + (@so_profile.reputation / 100) }
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/5056" }
    it { @so_profile.reputation.should_not be_nil }
    it { @so_profile.stack_overflow_tags.should_not be_nil }
    it { @so_profile.questions.count.should > 0 }
    it { @so_profile.answers.count.should > 0 }
  end
  
  describe "sync 83667" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => 83667)
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload
  
      VCR.use_cassette("stack_overflow_sync_83667", :record => :all) do
        SyncStackOverflowProfileJob.perform(@so_profile.id)
      end
      @profile.reload
      @so_profile.reload
    end
  
    it { @so_profile.url.should == "http://www.stackoverflow.com/users/83667" }
    it { @so_profile.reputation.should_not be_nil }
  end
  
  describe "sync Jared314" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @so_profile = StackOverflowProfile.new(:stack_overflow_id => "Jared314")
      @profile.stack_overflow_profile = @so_profile
      @so_profile.save
      @so_profile.stubs(:retag!)
      @profile.reload

      VCR.use_cassette("stack_overflow_sync_Jared314", :record => :all) do
        SyncStackOverflowProfileJob.perform(@so_profile.id)
      end
      @profile.reload
      @so_profile.reload
    end

    it { @so_profile.url.should be_nil }
  end

end