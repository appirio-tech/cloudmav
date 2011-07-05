Given /^there is a user "([^"]*)"$/ do |username|
  @user = Factory.create(:user, :username => username)
end

When /^I send a GET request to "([^"]*)"$/ do |url|
  get url
end

Then /^the response should be "([^"]*)"$/ do |code|
  response.status.should == code.to_i
end

Then /^the response should have "([^"]*)"'s profile data$/ do |username|
  result = JSON.parse(response.body)
  result["profile"]["username"].should == username
end
