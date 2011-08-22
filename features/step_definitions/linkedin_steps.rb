Given /^I have a LinkedIn profile$/ do
  profile = Profile.find(@profile.id)
  profile.linkedin_profile = LinkedinProfile.create(:profile => profile)
  profile.save
end

Given /^I have jobs$/ do
  profile = Profile.find(@profile.id)
  3.times do |i|
    profile.jobs << Job.create(:title => "job #{i}", :profile => profile)
  end
  profile.save
end

When /^I delete my LinkedIn profile$/ do
  visit profile_experience_path(@profile)
  click_link "delete_linkedin"
end

Then /^I should not have a LinkedIn profile$/ do
  Profile.find(@profile.id).linkedin_profile.should be_nil
end

Then /^I should not have any jobs$/ do
  profile = Profile.find(@profile.id)
  profile.jobs.count.should == 0
end

Then /^I should not have any job events$/ do
  JobAddedEvent.for_profile(@profile).count.should == 0
end



