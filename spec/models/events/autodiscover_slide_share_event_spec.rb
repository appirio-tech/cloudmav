require 'spec_helper'

describe "autodiscover slide share" do

  describe "discover" do
    before(:each) do
      @profile = Factory.create(:user, :username => "rookieone").profile
      event = AutodiscoverSlideShareEvent.new(:profile => @profile)
      VCR.use_cassette("autodiscover slideshare", :record => :new_episodes) do
        event.do_work
      end
    end

    it { @profile.slide_share_profile.should_not be_nil }
  end

end
