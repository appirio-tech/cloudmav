Given /^I am a visitor$/ do
end

When /^I register with my information$/ do
  @user = Factory.build(:user)
  fill_in :username, :with => @user.username
  fill_in :email, :with => @user.email
  fill_in :password, :with => @user.password
  fill_in "Password confirmation", :with => @user.password_confirmation

  click_button "Sign up"
end

Then /^I should be registered$/ do
  user = User.where(:email => @user.email).first
  user.should_not be_nil
end

Then /^I should have a profile$/ do
  user = User.where(:email => @user.email).first
  user.profile.should_not be_nil
end

Then /^my profile email should be my user email$/ do
  user = User.where(:email => @user.email).first
  user.profile.email.should == @user.email
end


