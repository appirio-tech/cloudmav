Given /^I have a GitHub profile$/ do
  @git_hub_profile = Factory.create(:git_hub_profile, :profile => @profile)
end

Given /^I have a GitHub repository$/ do
  @git_hub_repository = GitHubRepository.new
  @git_hub_repository.git_hub_profile = @git_hub_profile
  @git_hub_repository.save
end

Then /^my GitHub repository should have a score$/ do
  @git_hub_repository.reload
  @git_hub_repository.total_score.should > 0
end
