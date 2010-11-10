Given /^I have an account$/ do
  @user = Factory.create(:user)
end

When /^I login$/ do
  fill_in :email, :with => @user.email
  fill_in :password, :with => @user.password
  click_button "Sign in"
  And %Q{I should be redirected}
end

Then /^I should be logged in$/ do
  And %Q{I should see "logged in as #{@user.email}"}
end
