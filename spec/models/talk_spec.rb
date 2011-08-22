require 'spec_helper'

describe Talk do

  context "new" do
    it { subject.willing_to_give_talk_again.should == true }
  end

end
