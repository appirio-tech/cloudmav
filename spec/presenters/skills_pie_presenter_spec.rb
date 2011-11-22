require 'spec_helper'

describe SkillsPiePresenter do
  before(:each) do
    @profile = Factory.create(:user).profile
  end
  
  context "One skill" do
    before(:each) do
      @profile.earn_skill(100, "ruby", :coder, "for GitHub repository", GitHubRepository.new)
      @profile.earn_skill(20, "ruby", :coder, "for StackOverflow", StackOverflowProfile.new)
      @data = SkillsPiePresenter.get_data(@profile)
    end
    it { @data["ruby"].should == [120, 100] }
  end

end