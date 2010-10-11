Given /^I am a visitor$/ do
  puts "tests"
end

When /^I register with my information$/ do
  fill_in :email, :with => "someone@email.com"
  fill_in :password, :with => "secret"
  fill_in :password_confirmation, :with => "secret"
  click_button "Sign up"
end

Then /^I should be registered$/ do
  user = User.find_by_email("someone@email.com")
end

Then /^an email confirmation sent$/ do
  email = ActionMailer::Base.deliveries.first
  email.should_not be_nil
end


Given /^nothing$/ do

end

When /^something$/ do

end

Then /^I should pass$/ do
  assert true
end
