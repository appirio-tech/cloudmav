require 'spec_helper'

describe "Dev Journey Jobs" do
  
  context "Two jobs" do
    before(:each) do
      @profile = Factory.create(:user).profile
      
      Job.create(:profile => @profile, :start_date => DateTime.parse("10/1/2010"), :end_date => DateTime.parse("30/5/2010"))      
      Job.create(:profile => @profile, :start_date => DateTime.parse("8/8/2010"), :end_date => DateTime.parse("30/11/2010"))
      
      @data = DevJourneyJobsPresenter.get_data(@profile)
    end
    it { @data[:data].count.should == 2 }
    it { @data[:javascript_data].should_not be_nil }   
  end
  
end