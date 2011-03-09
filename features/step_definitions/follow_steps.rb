When /^I follow the user "([^"]*)"$/ do |username|
  visit profile_path(:username => username)
  click_button "Follow"
  And "I should be redirected"
  And "show me the page"
end

Then /^I should be following "([^"]*)"$/ do |username|
  profile = Profile.find(@profile.id)
  followee = Profile.by_username(username).first
  profile.follows?(followee).should == true
end

Then /^"([^"]*)" should have me as a follower$/ do |username|
  profile 

end
 
