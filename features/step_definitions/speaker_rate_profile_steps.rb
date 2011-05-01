When /^I synch my SpeakerRate account$/ do
  VCR.use_cassette('speaker_rate', :record => :new_episodes) do
    visit new_profile_speaker_rate_profile_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => '10082'
    click_button "Save"
  end
end

Then /^I should have a SpeakerRate profile$/ do
  profile = User.find(@user.id).profile
  profile.speaker_rate_profile.should_not be_nil
end

Then /^I should have my talks from SpeakerRate$/ do
  profile = User.find(@user.id).profile
  profile.talks.where(:title => "Virtual Brown Bag").count.should == 1
end

Given /^I synched my SpeakerRate account$/ do
  VCR.use_cassette('speaker_rate', :record => :new_episodes) do
    visit new_profile_speaker_rate_profile_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => '10082'
    click_button "Save"
  end
end

Then /^I should not have duplicate talks from SpeakerRate$/ do
  profile = User.find(@user.id).profile
  profile.talks.where(:title => "Virtual Brown Bag").count.should == 1
end

When /^I view their speaker profile$/ do
  visit profile_speaking_path(@other_user.profile)
end

Then /^I should not see their SpeakerRate profile$/ do
  page.has_no_selector?("#speaker_rate_info").should == true
end

Given /^the other user has a SpeakerRate profile$/ do
  VCR.use_cassette('other speaker_rate ', :record => :new_episodes) do
    Factory.create(:speaker_rate_profile, :speaker_rate_id => "10082", :profile => @other_user.profile)
    @other_user.profile.save
  end
end

Then /^I should see their SpeakerRate profile$/ do
  page.has_selector?("#speaker_rate_info").should == true
end

