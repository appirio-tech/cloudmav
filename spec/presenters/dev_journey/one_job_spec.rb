require 'spec_helper'

describe DevJourneyPresenter do
  
  context "One job" do    
    before(:each) do
      @profile = Factory.create(:user).profile
      sd = DateTime.parse("10/1/2010")
      ed = DateTime.parse("30/5/2010")
      job = Job.create(:start_date => sd, :end_date => ed)
      @profile.earn_skill(100, "ruby", :coder, "for job", job)
      @data = DevJourneyPresenter.get_data(@profile)
    end
    it { @data[0][:name].should == "ruby" }
    it "should have the data" do
      @data[0][:data].should == [
      {:date=>"01/01/2010", :score=> 20}, 
      {:date=>"02/01/2010", :score=> 40}, 
      {:date=>"03/01/2010", :score=> 60}, 
      {:date=>"04/01/2010", :score=> 80}, 
      {:date=>"05/01/2010", :score=> 100}
      ]
    end      
  end
  
end