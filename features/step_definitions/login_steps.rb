Given /^I have an account$/ do
  @user = Factory.create(:user)
  @profile = @user.profile
end

When /^I login$/ do
  fill_in "user_username", :with => @user.username
  fill_in "user_password", :with => @user.password
  click_button "Sign in"
end

Then /^I should be logged in$/ do
  And %Q{I should see "#{@user.username}"}
end

Given /^I am logged in$/ do
  @user = Factory.create(:user)
  @profile = User.find(@user.id).profile
  @profile.autodiscover_histories.create(:name => "GitHub")

  And %Q{I go to the login page}
  fill_in "user_username", :with => @user.username
  fill_in "user_password", :with => 'secret'
  click_button "Sign in"
end
