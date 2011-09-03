Given /^there is a user$/ do
  @user = Factory.create(:user)
end

Given /^the user has a talk$/ do
  @talk = Factory.create(:talk, :profile => @user.profile)
end

When /^I am looking at the talk$/ do
  visit profile_talk_path(@user.profile, @talk)
end

Then /^I should see the user does not have a speaker rate account$/ do
  page.should have_content("#{@user.profile.display_name} has not signed up for a SpeakerRate account yet")
end

Given /^the user has a speaker rate profile$/ do
  Factory.create(:speaker_rate_profile, :profile => @user.profile)
end

Then /^I should see the user has not added the talk to speaker rate yet$/ do
  And "show me the page"
  page.should have_content("#{@user.profile.display_name} has not added the talk to their SpeakerRate account yet")
end

