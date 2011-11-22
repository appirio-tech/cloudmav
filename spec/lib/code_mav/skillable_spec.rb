require 'spec_helper'

describe "Skillable" do
  describe "skills" do
    before(:each) do
      @profile = Factory.create(:user).profile
      @profile.earn_skill(100, "ruby", :coder, "for repo", GitHubRepository.new)
      @profile.earn_skill(300, "csharp", :coder, "for repo", GitHubRepository.new)
      @skills = @profile.skills
    end
    it { @skills.should include "ruby" }
    it { @skills.should include "csharp" }
  end
end