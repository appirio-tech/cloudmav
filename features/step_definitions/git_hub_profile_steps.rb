When /^I sync my GitHub account$/ do
  VCR.use_cassette("github", :record => :new_episodes) do
    visit new_profile_git_hub_profile_path(@profile)
    fill_in "git_hub_profile_username", :with => 'rookieone'
    click_button "Save"
  end
end

Then /^I should have a GitHub profile$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.should_not be_nil
end

Then /^I should have a collection of my repos$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.repositories.count.should > 0
  GitHubRepositoryAddedEvent.count.should > 0
end

Then /^my GitHub profile should be tagged$/ do
  profile = User.find(@user.id).profile
  git_hub_profile = profile.git_hub_profile
  git_hub_profile.tags.count.should > 0
end

Then /^my profile should have my GitHub profile tags$/ do
  profile = User.find(@user.id).profile
  profile.tags.count.should > 0
end

When /^I view their code profile$/ do
  visit profile_code_path(@other_user.profile)
end

Given /^the other user has a GitHub profile$/ do
  VCR.use_cassette("other github", :record => :new_episodes) do
    Factory.create(:git_hub_profile, :username => "rookieone", :profile => @other_user.profile, :last_synced_date => DateTime.now)
    @other_user.profile.save
  end
end

Then /^I should not see their GitHub profile$/ do
  And %Q{I should not see "Go to my GitHub Profile"}
end

Then /^I should see their GitHub profile$/ do
  And %Q{I should see "Go to my GitHub Profile"}
end

