Given /^I am a visitor$/ do
end

When /^I register with my information$/ do
  fill_in :email, :with => "someone@email.com"
  fill_in :password, :with => "secret"
  fill_in "Password confirmation", :with => "secret"

  click_button "Sign up"
end

Then /^I should be registered$/ do
  user = User.where(:email => "someone@email.com")
end

Then /^I should have a profile$/ do
  user = User.where(:email => "someone@email.com")
end

