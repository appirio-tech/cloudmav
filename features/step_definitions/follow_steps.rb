When /^I follow the user "([^"]*)"$/ do |username|
  visit profile_path(:username => username)
  click_button "Follow"
end

Then /^I should be following "([^"]*)"$/ do |username|
  profile = Profile.find(@profile.id)
  followee = Profile.by_username(username).first
  profile.follows?(followee).should == true
end

Then /^"([^"]*)" should have me as a follower$/ do |username|
  profile = Profile.by_username(username).first
  profile.follower?(@profile).should == true 
end

Given /^user "([^"]*)" is following me$/ do |username|
  profile = Profile.by_username(username).first
  profile.follow!(@profile)
end

Then /^"([^"]*)" should be my friend$/ do |username|
  profile = Profile.by_username(username).first
  profile.friend?(@profile).should == true
  @profile.friend?(profile).should == true
end

Then /^I should see "([^"]*)" on my social page$/ do |username|
  visit profile_social_path(@profile)
end

When /^I unfollow "([^"]*)" from their profile page$/ do |username|
  visit profile_path(username)
  click_button "unfollow"
end

Then /^I should not be following "([^"]*)"$/ do |username|
  profile = Profile.find(@profile.id)
  followee = Profile.by_username(username).first
  profile.follows?(followee).should == false
end

Then /^there should not be a duplicate following of "([^"]*)"$/ do |username|
  profile = Profile.find(@profile.id)
  followee = Profile.by_username(username).first
  profile.followings.where(:subject_id => followee.id).count.should == 1
end
 
