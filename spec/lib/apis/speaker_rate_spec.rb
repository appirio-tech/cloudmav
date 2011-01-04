require 'spec_helper'

describe SpeakerRate do

  describe "get talks for user" do
    before(:each) do
      @talks = SpeakerRate.get_talks(10082)
    end
    
    it { @talks.should_not be_nil }
    it { @talks.should_not be_empty }
  end

end