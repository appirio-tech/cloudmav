Then /^I should be awarded the "([^"]*)" badge$/ do |name|
  @profile.reload
  @profile.has_badge_named?(name).should == true
end