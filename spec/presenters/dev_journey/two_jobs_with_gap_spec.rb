require 'spec_helper'

describe "Dev Journey" do
  
  context "Two jobs with gap" do
    before(:each) do
      @profile = Factory.create(:user).profile
      
      job = Job.create(:start_date => DateTime.parse("10/1/2010"), :end_date => DateTime.parse("30/5/2010"))
      @profile.earn_skill(100, "ruby", :coder, "for job", job)
      
      job = Job.create(:start_date => DateTime.parse("8/8/2010"), :end_date => DateTime.parse("30/11/2010"))
      @profile.earn_skill(100, "ruby", :coder, "for job", job)
      
      @data = DevJourneyPresenter.get_data(@profile)
    end
    it { @data[:data][0][:name].should == "ruby" }
    it "should have the data" do
      @data[:data][0][:data].should == [
        {:date=>"01/01/2010", :score=> 20}, 
        {:date=>"02/01/2010", :score=> 40}, 
        {:date=>"03/01/2010", :score=> 60}, 
        {:date=>"04/01/2010", :score=> 80}, 
        {:date=>"05/01/2010", :score=> 100}, 
        {:date=>"06/01/2010", :score=> 100}, 
        {:date=>"07/01/2010", :score=> 100}, 
        {:date=>"08/01/2010", :score=> 125}, 
        {:date=>"09/01/2010", :score=> 150}, 
        {:date=>"10/01/2010", :score=> 175},                 
        {:date=>"11/01/2010", :score=> 200}
        ]
    end
    it { @data[:start_date].should == "01/01/2010" }
    it { @data[:highest_score].should == 200 }    
  end
  
end