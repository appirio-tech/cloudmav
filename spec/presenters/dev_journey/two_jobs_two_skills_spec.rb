require 'spec_helper'

describe "Dev Journey" do
  
  context "Two jobs, Two skills" do
    before(:each) do
      @profile = Factory.create(:user).profile
      
      job = Job.create(:start_date => DateTime.parse("10/1/2010"), :end_date => DateTime.parse("30/5/2010"))
      @profile.earn_skill(100, "ruby", :coder, "for job", job)
      
      job = Job.create(:start_date => DateTime.parse("1/4/2010"), :end_date => DateTime.parse("30/9/2010"))
      @profile.earn_skill(100, "csharp", :coder, "for job", job)
      
      @data = DevJourneyPresenter.get_data(@profile)
    end
    it { @data[:data][0][:name].should == "ruby" }
    it "should have the ruby data" do
      @data[:data][0][:data].should == [
        {:date=>"01/01/2010", :score=>20}, 
        {:date=>"02/01/2010", :score=>40}, 
        {:date=>"03/01/2010", :score=>60}, 
        {:date=>"04/01/2010", :score=>80}, 
        {:date=>"05/01/2010", :score=>100}]
    end
    it { @data[:data][1][:name].should == "csharp" }
    it "should have the csharp data" do
      @data[:data][1][:data].should == [
        {:date=>"04/01/2010", :score=>16}, 
        {:date=>"05/01/2010", :score=>32}, 
        {:date=>"06/01/2010", :score=>48}, 
        {:date=>"07/01/2010", :score=>64}, 
        {:date=>"08/01/2010", :score=>80}, 
        {:date=>"09/01/2010", :score=>96}
        ]
    end
    it { @data[:start_date].should == "01/01/2010" }
    it { @data[:highest_score].should == 100 }    
  end
end