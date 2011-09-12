Then /^I should be awarded the "([^"]*)" badge$/ do |name|
  profile = User.find(@user.id).profile
  profile.has_badge_named?(name).should == true
end