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
  @location = { :location => "Houston, TX", :lat => 30, :lng => -90 }
  fill_in :location, :with => @location[:location]
  fill_in :lat, :with => @location[:lat]
  fill_in :lng, :with => @location[:lng]
  click_button "Save"
  And %Q{I am redirected}
end

Then /^my location should be updated$/ do
  profile = Profile.find(@user.profile.id)
  
  profile.location.should == @location[:location]
  profile.lat.should == @location[:lat]
  profile.lng.should == @location[:lng]
  profile.coordinates.should_not be_nil
end

