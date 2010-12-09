When /^I synch my GitHub account$/ do
  visit new_git_hub_profile_path
  fill_in "git_hub_profile_username", :with => 'rookieone'
  click_button "Synch"
  And %Q{I should be redirected}
end

Then /^I should have a GitHub profile$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.should_not be_nil
end
