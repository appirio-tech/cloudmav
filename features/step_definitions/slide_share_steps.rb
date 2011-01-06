When /^I synch my SlideShare account$/ do
  visit new_my_slide_share_profile_path
  fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
  click_button "Synch"
  And %Q{I should be redirected}
end

Then /^I should have a SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.should_not be_nil
end
