When /^I sync my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit edit_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    within "#sync_slide_share" do
      click_button "Sync"
    end
  end
end

Then /^I should have a SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.should_not be_nil
end

Then /^I should import my talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.count.should > 0
end

Then /^my talks should have their SlideShare info$/ do
  profile = Profile.find(@profile.id)
  talk = profile.talks.where(:title => "Techfest design patterns").first
  talk.has_slide_share.should == true
  talk.slideshow_html.should_not be_blank
end

Then /^I should have a slide count on my SlideShare profile$/ do
  profile = User.find(@user.id).profile
  profile.slide_share_profile.slides_count.should_not == 0
end

When /^I sync my SlideShare account that has only (\d+) slide$/ do |num|
  VCR.use_cassette("slide_share one_slide", :record => :new_episodes) do
    visit new_profile_slide_share_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'togakangaroo'
    click_button "Save"
  end
end

Given /^I have synced my SlideShare account$/ do
  VCR.use_cassette("slide_share", :record => :new_episodes) do
    visit edit_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => 'rookieone'
    within("#sync_slide_share") do
      click_button "Sync"
    end
  end
end

Then /^I should not have duplicate talks from SlideShare$/ do
  profile = Profile.find(@profile.id)
  profile.talks.where(:title => "Techfest design patterns").count.should == 1
end

Given /^the other user has a SlideShare profile$/ do
  VCR.use_cassette('other slide_share ', :record => :new_episodes) do
    Factory.create(:slide_share_profile, :slide_share_username => "rookieone", :profile => @other_user.profile)
    @other_user.profile.save
    User.find(@other_user.id).profile.slide_share_profile.sync!
  end
end

When /^I look at their talk from SlideShare$/ do
  p = User.find(@other_user.id).profile
  talk = User.find(@other_user.id).profile.talks.first
  visit profile_talk_path(p, talk)
end

Then /^I should be able to download the slides$/ do
  page.should have_content("Download the slides")
end

Then /^I should see a slideshow$/ do
  page.should have_css("#slideshow")
end

Then /^I should not see their SlideShare profile$/ do
  page.has_no_selector?("#slide_share_info").should == true
end

Then /^I should see their SlideShare profile$/ do
  page.has_selector?("#slide_share_info").should == true
end

Given /^I have a SlideShare profile$/ do
  VCR.use_cassette("my slide_share", :record => :new_episodes) do
    ss = Factory.create(:slide_share_profile, :slide_share_username => "rookieone", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    ss.sync!
  end
end

When /^I edit my SlideShare username$/ do
  VCR.use_cassette("edit slideshare", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @old_talks = profile.talks.to_a
    visit edit_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => "themoleskin"
    within "#sync_slide_share" do
      click_button "Sync"
    end
  end
end

Then /^my old talks should be not have their SlideShare info$/ do
  profile = Profile.find(@profile.id)
  talk = profile.talks.where(:title => "Techfest design patterns").first
  talk.has_slide_share.should == false
  talk.slideshow_html.should be_nil
end

When /^I delete my SlideShare profile$/ do
  visit edit_profile_path(@profile)
  profile = Profile.find(@profile.id)
  @old_talks = profile.talks.to_a
  click_link "delete_slide_share"
end

Then /^I should not have a SlideShare profile$/ do
  Profile.find(@profile.id).slide_share_profile.should be_nil
end

When /^I sync my SlideShare account with username "([^"]*)"$/ do |username|
  VCR.use_cassette("slide_share_#{username}", :record => :new_episodes) do
    visit edit_profile_path(@profile)
    fill_in "slide_share_profile_slide_share_username", :with => username
    within "#sync_slide_share" do
      click_button "Sync"
    end
  end
end

Then /^my SlideShare profile should have the url$/ do
  @profile.reload  
  @profile.slide_share_profile.url.should == "http://www.slideshare.net/#{@profile.slide_share_profile.slide_share_username}"
end


