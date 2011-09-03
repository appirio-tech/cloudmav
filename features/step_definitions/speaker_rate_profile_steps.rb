When /^I sync my SpeakerRate account$/ do
  VCR.use_cassette('speaker_rate', :record => :new_episodes) do
    visit new_profile_speaker_rate_profile_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => '10082'
    click_button "Save"
  end
end

Then /^my talks should have their SpeakerRate info$/ do
  profile = User.find(@user.id).profile
  talk = profile.talks.where(:title => "Virtual Brown Bag").first
  talk.speaker_rate_id.should_not be_nil
  talk.speaker_rate_url.should_not be_nil
end

Then /^I should have a SpeakerRate profile$/ do
  profile = User.find(@user.id).profile
  profile.speaker_rate_profile.should_not be_nil
end

Then /^I should have my talks from SpeakerRate$/ do
  profile = User.find(@user.id).profile
  profile.talks.where(:title => "Virtual Brown Bag").count.should == 1
end

Given /^I synced my SpeakerRate account$/ do
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

Then /^my SpeakerRate profile should be synced$/ do
  profile = Profile.find(@profile.id)
  profile.speaker_rate_profile.should be_synced
end

Given /^I have a SpeakerRate profile$/ do
  VCR.use_cassette("my speaker_rate", :record => :new_episodes) do
    sr = Factory.create(:speaker_rate_profile, :speaker_rate_id => "10082", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    sr.sync!
  end
end

When /^I edit my SpeakerRate id$/ do
  VCR.use_cassette("edit speakerrate", :record => :new_episodes) do
    profile = Profile.find(@profile.id)
    @speaker_rate_events = SpeakerRateProfileAddedEvent.all.to_a
    @old_talks = profile.talks.to_a
    visit profile_speaking_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => "3274"
    click_button "speaker_rate_profile_submit"
  end
end

Then /^my old SpeakerRate events should be deleted$/ do
  old_ids = @speaker_rate_events.map(&:id)
  SpeakerRateProfileAddedEvent.any_in(:_id => old_ids).count.should == 0
end

Then /^my old talks should be deleted$/ do
  old_ids = @old_talks.map(&:id)
  Talk.any_in(:_id => old_ids).count.should == 0
end

Then /^I should have my new talks$/ do
  Profile.find(@profile.id).talks.count.should > 0
end

When /^I delete my SpeakerRate profile$/ do
  visit profile_speaking_path(@profile)
  profile = Profile.find(@profile.id)
  @speaker_rate_events = SpeakerRateProfileAddedEvent.all.to_a
  @old_talks = profile.talks.to_a
  click_link "delete_speaker_rate"
end

Then /^I should not have a SpeakerRate profile$/ do
  Profile.find(@profile.id).speaker_rate_profile.should be_nil
end

