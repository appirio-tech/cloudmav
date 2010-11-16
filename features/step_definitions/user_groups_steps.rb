When /^I add a user group "([^"]*)"$/ do |name|
  @user_group = Factory.build(:user_group, :name => name)
  And %Q{I am on the add a user group page}
  fill_in :name, :with => @user_group.name
  click_button "Add"
  And %Q{I should be redirected}
end

Then /^the user group should be added$/ do
  user_group = UserGroup.where(:name => @user_group.name).first
  user_group.should_not be_nil
end
