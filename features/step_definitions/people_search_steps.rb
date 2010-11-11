
Given /^"([^"]*)" is located at "([^"]*)"$/ do |name, location|
  response = Geokit::Geocoders::MultiGeocoder.geocode(location)
  @user = Factory.create(:user)
  @user.profile.name = name
  @user.profile.lat = response.lat
  @user.profile.lng = response.lng
  @user.profile.save!
end

When /^I search for people near "([^"]*)"$/ do |location|
  And %Q{I go to the people search page}
  fill_in "location", :with => location
  click_button "Search"
end
