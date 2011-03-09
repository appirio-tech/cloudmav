require 'spec_helper'

describe "Learn to synch with Stack Overflow" do
  before(:each) do
    Virgil::Dsl.class_eval(File.read('spec/lib/virgil/stackoverflow_guidance.rb'))
    @profile = Factory.create(:user).profile
  end
  
  context "Has not synched" do
    before(:each) do
      @guidance = @profile.get_guidance
    end
    
    it { @guidance.should_not be_nil }
  end
  
  context "Has synched" do
    before(:each) do
      StackOverflowProfile.create(:profile => @profile)
      @profile.save
      @guidance = @profile.get_guidance
    end
    
    it { @guidance.should be_nil }    
  end
  
end
