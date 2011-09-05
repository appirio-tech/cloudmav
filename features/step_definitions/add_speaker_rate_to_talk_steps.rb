When /^I try to link my talk to Speaker Rate$/ do
  visit new_profile_talk_link_to_speaker_rate_path(@profile, @talk)
end

Then /^I should be able to add my talk to Speaker Rate$/ do
  And %Q{I should see "Add talk to SpeakerRate"}
end

Given /^I have a talk from SpeakerRate$/ do
  @speaker_rate_talk = Factory.create(:talk, :profile => @profile)
  @speaker_rate_talk.has_speaker_rate = true
  @speaker_rate_talk.speaker_rate_id = "100"
  @speaker_rate_talk.speaker_rating = 4.0
  @speaker_rate_talk.save
end

When /^I link the talk to the SpeakerRate talk$/ do
  visit new_profile_talk_link_to_speaker_rate_path(@profile, @talk)
  click_button "Link"
end

Then /^the talk should have my SpeakerRate info$/ do
  @talk.reload
  @talk.speaker_rate_id.should == "100"
end

Then /^my SpeakerRate talk should be deleted$/ do
  Talk.where(:id => @speaker_rate_talk.id).first.should == nil
end

Given /^I added a talk to SpeakerRate$/ do
end

When /^I refresh from the link my talk to SpeakerRate$/ do
  @speaker_rate_profile = SpeakerRateProfile.new(:profile => @profile, :speaker_rate_id => "10082")
  @speaker_rate_profile.stubs(:sync!)
  @speaker_rate_profile.save

  visit new_profile_talk_link_to_speaker_rate_path(@profile, @talk)
  VCR.use_cassette('refresh_link_to_speaker_rate', :record => :new_episodes) do
    click_link "Refresh"
  end
end

Then /^I should be able to select the SpeakerRate talk$/ do
  And "show me the page"
  page.has_content?("Virtual Brown Bag").should == true
end

Then /^all the Talk events for the SpeakerRate talk should be deleted$/ do
  TalkEvent.for_talk(@speaker_rate_talk).count.should == 0
end

