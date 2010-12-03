require 'spec_helper'

describe "Learn to synch with Stack Overflow" do
  before(:each) do
    Virgil::Dsl.class_eval(File.read('spec/lib/virgil/stackoverflow_guidance.rb'))
    @profile = Profile.new
  end
  
  context "Has not synched" do
    before(:each) do
      @guidance = @profile.get_guidance
    end
    
    it { @guidance.should_not be_nil }
  end
  
  context "Has synched" do
    before(:each) do
      @profile.stack_overflow_profile = StackOverflowProfile.new
      @profile.save
      @guidance = @profile.get_guidance
    end
    
    it { @guidance.should be_nil }    
  end
  
end