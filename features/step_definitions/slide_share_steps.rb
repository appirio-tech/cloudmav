When /^I sync my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit new_profile_slide_share_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    click_button "Save"
  end
end

When /^I sync my SlideShare account that has only (\d+) slide$/ do |num|
  VCR.use_cassette("slide_share one_slide", :record => :new_episodes) do
    visit new_profile_slide_share_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'togakangaroo'
    click_button "Save"
  end
end

Then /^I should have a SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.should_not be_nil
end

Given /^I have synced my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit new_profile_slide_share_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    click_button "Save"
  end
end

Then /^I should not have duplicate talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.where(:title => "Techfest design patterns").count.should == 1
end

Then /^I should import my talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.count.should > 0
end

Then /^I should not see their SlideShare profile$/ do
  page.has_no_selector?("#slide_share_info").should == true
end

Given /^the other user has a SlideShare profile$/ do
  VCR.use_cassette('other slide_share ', :record => :new_episodes) do
    Factory.create(:slide_share_profile, :slide_share_username => "rookieone", :profile => @other_user.profile)
    @other_user.profile.save
    User.find(@other_user.id).profile.slide_share_profile.sync!
  end
end

Then /^I should see their SlideShare profile$/ do
  page.has_selector?("#slide_share_info").should == true
end

When /^I look at their talk from SlideShare$/ do
  p = User.find(@other_user.id).profile
  talk = User.find(@other_user.id).profile.talks.first
  visit profile_talk_path(p, talk)
end

Then /^I should be able to download the slides$/ do
  page.should have_css("#download_link")
end

Then /^I should see a preview of the slides$/ do
  page.should have_css(".talk_pic img")
end

Then /^I should see a slideshow$/ do
  page.should have_css(".slideshow")
end

Then /^I should have a slide count on my SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.slides_count.should_not == 0
end

