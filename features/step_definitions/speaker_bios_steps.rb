When /^I add a speaker bio$/ do
  visit new_profile_speaker_bio_path(@profile)
  fill_in "speaker_bio_bio", :with => "My speaker bio"
  click_button "Save"
end

Then /^I should have a speaker bio$/ do
  profile = Profile.find(@profile.id)
  profile.speaker_bios.first.bio.should == "My speaker bio"
end
