Given /^I just signed up$/ do
  visit new_user_registration_path
  fill_in "user_username", :with => "rookieone"
  fill_in "user_email", :with => "rookieone@gmail.com"
  fill_in "user_password", :with => "test123"

  VCR.use_cassette("autodiscover_feature", :record => :new_episodes) do
    click_button "Register"
  end
  @profile = Profile.where(:username => "rookieone").first
end

When /^I am autodiscovered$/ do
end

Then /^my GitHub account should be autodiscovered$/ do
  @profile.git_hub_profile.should_not be_nil
end

Then /^my Bitbucket account should be autodiscovered$/ do
  @profile.bitbucket_profile.should_not be_nil
end
