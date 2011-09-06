Then /^I should see the user does not have a Slide Share account$/ do
  page.should have_content("#{@user.profile.display_name} has not signed up for a SlideShare account yet")
end

Given /^the user has a Slide Share profile$/ do
  Factory.create(:slide_share_profile, :profile => @user.profile)
end

Then /^I should see the user has not added the slides to Slide Share yet$/ do
  And "show me the page"
  page.should have_content("#{@user.profile.display_name} has not added the slides to their SlideShare account yet")
end

