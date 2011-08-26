Given /^I just signed up$/ do
  visit new_user_registration_path
  fill_in "user_username", :with => "rookieone"
  fill_in "user_email", :with => "rookieone@gmail.com"
  fill_in "user_password", :with => "test123"

  VCR.use_cassette("autodiscover_feature", :record => :new_episodes) do
    click_button "Register"
  end
end

When /^I am autodiscovered$/ do
end

Then /^my GitHub account should be autodiscovered$/ do

end

