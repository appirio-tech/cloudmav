Given /^I have a profile$/ do
  @profile = Factory.create(:user).profile
end

Given /^I have a talk tagged with "([^"]*)"$/ do |tag|
  @talk = Factory.create(:talk, :profile => @profile)
  @talk.tags_text = tag
  @talk.save
  @talk.retag!
end

When /^my profile's tags are calculated$/ do
  profile = Profile.find(@profile.id)
  profile.retag!
end

Then /^my profile should have a "([^"]*)" tag$/ do |tag|
  profile = Profile.find(@profile.id)
  
  profile.has_tag?(tag).should == true
end

Given /^I have a stackoverflow profile tagged with "([^"]*)"$/ do |tag|
  profile = Profile.find(@profile.id)
  so_profile = Factory.create(:stack_overflow_profile, :profile => profile)
  profile.save
  so_profile.tags_text = tag
  so_profile.save
  so_profile.retag!
end

Given /^I have a job tagged with "([^"]*)"$/ do |tag|
  job = Factory.create(:job, :profile => @profile)
  job.tags_text = tag
  job.save
  job.retag!
  @profile.reload
end