Given /^I have a GitHub repo$/ do
  @git_hub_profile = Factory.create(:git_hub_profile, :profile => @profile)
  @git_hub_repository = GitHubRepository.new
  @git_hub_repository.name = "GitHub Repo"
  @git_hub_repository.git_hub_profile = @git_hub_profile
  @git_hub_repository.save
end

When /^I link my GitHub repo to my talk$/ do
  visit new_profile_talk_link_to_git_hub_repository_path(@profile, @talk)
  click_button "Link"
end

Then /^the talk should have my GitHub repo$/ do
  @talk.reload
  @talk.git_hub_repository.should_not be_nil
end

Then /^I should see the GitHub repo when I look at my talk$/ do
  visit profile_talk_path(@profile, @talk)
  And "show me the page"
  And %Q{I should see "GitHub Repo"}
end