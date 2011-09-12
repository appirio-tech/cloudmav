Then /^I should be awarded the "([^"]*)" badge$/ do |name|
  @profile.reload
  @profile.has_badge_named?(name).should == true
end

Then /^I should not have the "([^"]*)" badge$/ do |title|
  @profile.reload
  @profile.has_badge_named?(title).should == false
end