#require 'spec_helper'
#
#describe "score it" do
#  context "profile should have a score" do
#    before(:each) do
#      @profile = Profile.new
#    end
#    
#    it { @profile.total_score.should == 0 }
#  end
#  
#  context "add stack overflow profile earns 10 code points" do
#    before(:each) do
#      ScoreIt::Dsl.class_eval(File.read('spec/lib/score_it/basic_score.rb'))
#      @profile = Profile.new
#      @profile.stack_overflow_profile = StackOverflowProfile.new
#      @profile.save
#    end
#    
#    it { @profile.total_score.should == 10 }
#    it { @profile.score(:coder_points).should == 10 }
#  end
#  
#  context "having over 100 stack overflow rep earns 50 code points" do
#    before(:each) do
#      ScoreIt::Dsl.class_eval(File.read('spec/lib/score_it/basic_score.rb'))
#      @profile = Profile.new
#      @profile.stack_overflow_profile = StackOverflowProfile.new
#      @profile.save
#      @profile.stack_overflow_profile.reputation = 150
#      @profile.save
#    end
#    
#    it { @profile.total_score.should == 60 }
#    it { @profile.score(:coder_points).should == 60 }
#  end
#  
#end
