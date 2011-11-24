require 'spec_helper'

describe DevJourneyPresenter do  
  describe "as_javascript" do
    before(:each) do
      @data = [{
        :name => "ruby",
        :data => [
          {:date=>"01/01/2010", :score=>20}, 
          {:date=>"02/01/2010", :score=>20}, 
          {:date=>"03/01/2010", :score=>20}, 
          {:date=>"04/01/2010", :score=>40}, 
          {:date=>"05/01/2010", :score=>20}]
      }]          
      @javascript = DevJourneyPresenter.as_javascript(@data)
    end
    it { @javascript.should == %Q{[ { name: 'ruby', data: [ { date: Date.parse('01/01/2010'), score: 20 } ,  { date: Date.parse('02/01/2010'), score: 20 } ,  { date: Date.parse('03/01/2010'), score: 20 } ,  { date: Date.parse('04/01/2010'), score: 40 } ,  { date: Date.parse('05/01/2010'), score: 20 } ]} ]} }
  end
end