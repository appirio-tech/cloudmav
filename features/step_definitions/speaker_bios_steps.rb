When /^I set my speaker bio$/ do
  visit edit_speaker_bio_path(:username => @profile.username)
  fill_in :speaker_bio, :with => "My speaker bio"
end

Then /^I should have a speaker bio$/ do
  profile = Profile.find(@profile.id)
  profile.speaker_bio.should == "My speaker bio"
end
