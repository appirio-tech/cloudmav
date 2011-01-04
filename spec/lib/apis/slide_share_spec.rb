require 'spec_helper'

describe SlideShare do

  describe "find talks for user" do
    before(:each) do
      @talks = SlideShare.find_talks_for("rookieone")
    end
    
    it { @talks.should_not be_nil }
    it { @talks.should_not be_empty }
  end

end