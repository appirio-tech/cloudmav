When /^I synch my GitHub account$/ do
  VCR.use_cassette("github", :record => :new_episodes) do
    visit new_git_hub_profile_path(:username => @profile.username)
    fill_in "git_hub_profile_username", :with => 'rookieone'
    click_button "Synch"
  end
end

Then /^I should have a GitHub profile$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.should_not be_nil
end

Then /^I should have a collection of my repos$/ do
  profile = User.find(@user.id).profile
  profile.git_hub_profile.repositories.count.should > 0
end

