When /^I add a user group "([^"]*)"$/ do |name|
  @user_group = Factory.build(:user_group, :name => name)
  And %Q{I am on the add a user group page}
  fill_in "user_group_name", :with => @user_group.name
  click_button "Add"
end

Then /^the user group should be added$/ do
  user_group = UserGroup.where(:name => @user_group.name).first
  user_group.should_not be_nil
end

Given /^there is a user group "([^"]*)"$/ do |name|
  @user_group = Factory.create(:user_group, :name => name)
end

When /^I schedule a new meeting on "([^"]*)" for "([^"]*)"$/ do |date, user_group_name |
  And %Q{I am on the "#{user_group_name}" user group page} 
  And %Q{I follow "Schedule a meeting"}
  fill_in "meeting_title", :with => "New Meeting"
  fill_in "meeting_summary", :with => "Summary of new meeting"
  fill_in "start_time", :with => "6:00pm"
  fill_in "start_date", :with => date
  fill_in "end_time", :with => "9:00pm"
  fill_in "end_date", :with => date
		
  click_button "Schedule"
end

Then /^the meeting should be scheduled for "([^"]*)"$/ do |user_group_name|
  user_group = UserGroup.where(:name => user_group_name).first
  user_group.meetings.length.should == 1
end
