Given /^I am a user$/ do
  @user = Factory.create(:user)
end

When /^I am awarded a badge "([^"]*)"$/ do |title|
  User.find(@user.id).profile.award_badge(title)
end

Then /^I should be awarded the "([^"]*)" badge$/ do |name|
  profile = User.find(@user.id).profile
  profile.has_badge_named?(name).should == true
end

Then /^I should have the badge "([^"]*)" in my profile$/ do |title|
  @user.profile.reload
  assert @user.profile.has_badge_named?(title)
end
