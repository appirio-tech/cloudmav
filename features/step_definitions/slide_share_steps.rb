When /^I synch my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit new_slide_share_profile_path(:username => @profile.username)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    click_button "Synch"
    And %Q{I should be redirected}
  end
end

Then /^I should have a SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.should_not be_nil
end

Given /^I have synched my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit new_slide_share_profile_path(:username => @profile.username)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    click_button "Synch"
    And %Q{I should be redirected}
  end
end

Then /^I should not have duplicate talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.where(:title => "Techfest design patterns").count.should == 1
end

Then /^I should import my talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.where(:title => "Techfest design patterns").count.should == 1
end
