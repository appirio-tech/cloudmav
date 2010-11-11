When /^I synch my StackOverflow account$/ do
  visit new_stack_overflow_profile_path
  fill_in "stack_overflow_profile_stack_overflow_id", :with => '60336'
  click_button "Synch"
  And %Q{I should be redirected}
end

Then /^I should have a StackOverflow profile$/ do
  profile = User.find(@user.id).profile
  profile.stack_overflow_profile.should_not be_nil
end

Then /^I should be awarded the "([^"]*)" badge$/ do |name|
  profile = User.find(@user.id).profile
  puts "badges: #{profile.badges.to_a.inspect}"
end
