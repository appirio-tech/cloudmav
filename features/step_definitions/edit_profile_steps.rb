Given /^I am logged in$/ do
  @user = Factory.create(:user)
  And %Q{I go to the login page}
  fill_in :email, :with => @user.email
  fill_in :password, :with => 'secret'
  click_button "Sign in"
  And %Q{I am redirected}
end

When /^I edit my profile$/ do
  And %Q{I follow "Edit profile"}
end

When /^I change my name to "([^"]*)"$/ do |name|
  fill_in :name, :with => name
  click_button "Save"
  And %Q{I am redirected}
end

Then /^my name should be updated to "([^"]*)"$/ do |name|
  profile = Profile.find(@user.profile.id)
  profile.name.should == name
end

When /^I change my location$/ do
  @location = Factory.build(:location)
  fill_in :description, :with => @location.description
  fill_in :lat, :with => @location.lat
  fill_in :lng, :with => @location.lng
  click_button "Save"
  And %Q{I am redirected}
end

Then /^my location should be updated$/ do
  profile = Profile.find(@user.profile.id)
  
  profile.location.description.should == @location.description
  profile.location.lat.should == @location.lat
  profile.location.lng.should == @location.lng
end

