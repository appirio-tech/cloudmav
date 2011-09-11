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
  pending # express the regexp above with the code you wish you had
end

Then /^I should be awarded the "([^"]*)" badge$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^I should have coder points for my GitHub account$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should learned "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^my GitHub profile should be tagged$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^my profile should have my GitHub profile tags$/ do
  pending # express the regexp above with the code you wish you had
end
