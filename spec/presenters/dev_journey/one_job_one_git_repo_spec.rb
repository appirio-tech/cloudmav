require 'spec_helper'

describe "Dev Journey" do
  
  context "One job, One GitHub repository" do
    before(:each) do
      @profile = Factory.create(:user).profile
      
      job = Job.create(:start_date => DateTime.parse("10/1/2010"), :end_date => DateTime.parse("30/5/2010"))
      @profile.earn_skill(100, "ruby", :coder, "for job", job)
      
      git_profile = GitHubProfile.create(:profile => @profile)
      repo = git_profile.repositories.create(:creation_date => "2010/04/24 23:16:35 -0700")
      @profile.earn_skill(20, "ruby", :coder, "for repo", repo)
      
      @data = DevJourneyPresenter.get_data(@profile)
    end
    it { @data[:data][0][:name].should == "ruby" }
    it "should have the ruby data" do
      @data[:data][0][:data].should == [
        {:date=>"01/01/2010", :score=> 20}, 
        {:date=>"02/01/2010", :score=> 40}, 
        {:date=>"03/01/2010", :score=> 60}, 
        {:date=>"04/01/2010", :score=> 100}, 
        {:date=>"05/01/2010", :score=> 120}]        
    end     
    it { @data[:start_date].should == "01/01/2010" }
    it { @data[:highest_score].should == 120 }    
  end
end