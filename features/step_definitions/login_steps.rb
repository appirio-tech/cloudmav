Given /^I have an account$/ do
  @user = Factory.create(:user)
end

When /^I login$/ do
  fill_in :username, :with => @user.username
  fill_in :password, :with => @user.password
  click_button "Sign in"
  And %Q{I should be redirected}
end

Then /^I should be logged in$/ do
  And %Q{I should see "#{@user.username}"}
end

Given /^I am logged in$/ do
  @user = Factory.create(:user)
  And %Q{I go to the login page}
  fill_in :username, :with => @user.username
  fill_in :password, :with => 'secret'
  click_button "Sign in"
  And %Q{I am redirected}
  @profile = User.find(@user.id).profile
end