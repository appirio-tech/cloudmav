require 'spec_helper'

describe DevJourneyPresenter do
  
  context "No skills" do    
    before(:each) do
      @profile = Factory.create(:user).profile      
      @data = DevJourneyPresenter.get_data(@profile)
      puts @data.inspect
    end    
    it { @data[:start_date].should <= 11.months.ago }
    it { @data[:highest_score].should == 100 }
  end
  
end