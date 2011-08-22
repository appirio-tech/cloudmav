
# Generic redirects

# Given /^I am redirected$/ do
#   new_location = last_response['Location'].gsub('http://example.org', '')
#   visit new_location
# end

Then /^I should be redirected$/ do
  visit cleaned_redirect_location
end

When "I am redirected" do
  visit cleaned_redirect_location
end

# More specific redirects but no asserts. basically cosmetic / informative

When /^I am sent to the (.+) page$/ do |page_name|
  visit cleaned_redirect_location
end

Then /^I should be sent to the (.+) page$/ do |page_name|
  visit cleaned_redirect_location
  Then "I should be on the #{page_name} page"
end

# Click link

When /^(?:|I )click the "([^\"]*)" link$/ do |link|
  click_link(link)
end


def cleaned_redirect_location
  last_response['Location'].should_not be_nil, "Should have been redirected, but last_response['Location'] was nil"
  last_response['Location'].gsub('http://example.org', '')
end

When /^I follow the redirect$/ do
  follow_redirect!
end

When /^I press "([^"]*)" within "([^"]*)"$/ do |button, selector|
  within(selector) do
    click_button button
  end
end
