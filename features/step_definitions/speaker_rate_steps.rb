When /^I sync my SpeakerRate account$/ do
  VCR.use_cassette('speaker_rate', :record => :new_episodes) do
    visit profile_syncable_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => '10082'
    within("#sync_speaker_rate") do
      click_button "Sync"
    end
  end
end

Then /^I should have a SpeakerRate profile$/ do
  profile = User.find(@user.id).profile
  profile.speaker_rate_profile.should_not be_nil
end

Then /^my SpeakerRate profile should be synced$/ do
  profile = Profile.find(@profile.id)
  profile.speaker_rate_profile.should be_synced
end

Then /^I should have my talks from SpeakerRate$/ do
  profile = User.find(@user.id).profile
  profile.talks.where(:title => "Virtual Brown Bag").count.should == 1
end

Then /^my talks should have their SpeakerRate info$/ do
  profile = User.find(@user.id).profile
  talk = profile.talks.where(:title => "Virtual Brown Bag").first
  talk.speaker_rate_id.should_not be_nil
  talk.speaker_rate_url.should_not be_nil
end

Then /^I should have speaker points for SpeakerRate$/ do
  @profile.reload
  @profile.score(:speaker_points).should > 0
end

Given /^I synced my SpeakerRate account$/ do
  VCR.use_cassette('speaker_rate', :record => :new_episodes) do
    visit profile_syncable_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => '10082'
    within("#sync_speaker_rate") do
      click_button "Sync"
    end
  end
end

Then /^I should not have duplicate talks from SpeakerRate$/ do
  profile = User.find(@user.id).profile
  profile.talks.where(:title => "Virtual Brown Bag").count.should == 1
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
    @old_talks = profile.talks.to_a
    visit profile_syncable_path(@profile)
    fill_in "speaker_rate_profile_speaker_rate_id", :with => "3274"
    within "#sync_speaker_rate" do
      click_button "Sync"
    end
  end
end

Then /^I should have my new talks$/ do
  Profile.find(@profile.id).talks.count.should > 0
end

Then /^my talks should not have their SpeakerRate info$/ do
  @profile.reload
  talk = @profile.talks.where(:title => "Vim - One Week Challenge").first
  talk.has_speaker_rate.should == false
end

When /^I delete my SpeakerRate profile$/ do
  visit profile_syncable_path(@profile)
  profile = Profile.find(@profile.id)
  @old_talks = profile.talks.to_a
  click_link "delete_speaker_rate"
end

Then /^I should not have a SpeakerRate profile$/ do
  Profile.find(@profile.id).speaker_rate_profile.should be_nil
end
