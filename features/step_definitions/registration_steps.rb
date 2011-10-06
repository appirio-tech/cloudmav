Given /^I am a visitor$/ do
end

When /^I register with my information$/ do
  @user = Factory.build(:user)
  fill_in "user_username", :with => @user.username
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password

  VCR.use_cassette("register_my_info", :record => :new_episodes) do
    click_button "Register"
  end
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

Then /^I should be redirected to the autodiscover page$/ do
  user = User.where(:email => @user.email).first
  current_path = URI.parse(current_url).path
  current_path.should == new_profile_autodiscover_path(user.profile)
end

When /^I register from the home page$/ do
  visit root_path
  @user = Factory.build(:user)
  fill_in "user_username", :with => @user.username
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  VCR.use_cassette("register_homepage", :record => :new_episodes) do
    within ".register" do
      click_button "Register"
    end
  end
end

When /^I register with bad info on the home page$/ do
  visit root_path
  @user = Factory.build(:user)
  fill_in "user_username", :with => ""
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => ""
  VCR.use_cassette("register", :record => :new_episodes) do
    click_button "Register"
  end
end

Then /^I should not be registered$/ do
  user = User.where(:email => @user.email).first
  user.should be_nil
end

Then /^I should be redirected to edit my profile$/ do
  And %Q{I should see "Edit Profile"}
end