Given /^I have a LinkedIn profile$/ do
  profile = Profile.find(@profile.id)
  LinkedinProfile.create(:profile => profile)
end

Given /^I have jobs$/ do
  profile = Profile.find(@profile.id)
  3.times do |i|
    profile.jobs << Job.create(:title => "job #{i}", :profile => profile)
  end
  profile.save
end

When /^I delete my LinkedIn profile$/ do
  visit edit_profile_path(@profile)
  click_link "delete_linkedin"
end

Then /^I should not have a LinkedIn profile$/ do
  Profile.find(@profile.id).linkedin_profile.should be_nil
end

Then /^I should not have any jobs$/ do
  profile = Profile.find(@profile.id)
  profile.jobs.count.should == 0
end
