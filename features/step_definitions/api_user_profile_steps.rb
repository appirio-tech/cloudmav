Given /^there is a user "([^"]*)"$/ do |username|
  @user = Factory.create(:user, :username => username)
end

When /^I send a GET request to "([^"]*)"$/ do |url|
  get url
end

Then /^the response should be "([^"]*)"$/ do |code|
  last_response.status.should == code.to_i
end

Then /^the response should have "([^"]*)"'s profile data$/ do |username|
  result = JSON.parse(last_response.body)
  result["profile"]["username"].should == username
end

Given /^"([^"]*)" has a tag "([^"]*)" with a score of "([^"]*)"$/ do |username, tag, score|
  profile = Profile.where(:username => username).first
  t = Tag.find_or_create_named(tag)
  tagging = Tagging.new(:tag => t, :score => score)
  profile.taggings << tagging
  tagging.save
  profile.save
end

Then /^the response should have the "([^"]*)" tag with a score of "([^"]*)"$/ do |tag, score|
  result = JSON.parse(last_response.body)
  t = result["profile"]["tags"].select{|t| t["name"] == tag }.first
  t.should_not be_nil
  t["score"].should == score.to_i
end

