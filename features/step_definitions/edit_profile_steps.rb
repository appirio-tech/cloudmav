When /^I edit my profile$/ do
#  click_link "edit profile"
  l = find_link("edit profile")
  puts "l is #{l.inspect}"
  l.click
#  When %Q{I follow "edit profile"}
end

When /^I change my name to "([^"]*)"$/ do |name|
  And "show me the page"
  fill_in "profile_name", :with => name
  click_button "Save"
end

Then /^my name should be updated to "([^"]*)"$/ do |name|
  profile = Profile.find(@user.profile.id)
  profile.name.should == name
end

When /^I change my location$/ do
  @location = { :location => "Houston, TX", :lat => 30, :lng => -90 }
  fill_in "location", :with => @location[:location]
  click_button "Save"
end

Then /^my location should be updated$/ do
  profile = Profile.find(@user.profile.id)
  
  profile.location.should == @location[:location]
end
