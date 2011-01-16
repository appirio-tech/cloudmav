Given /^I have a profile$/ do
  @profile = Factory.create(:profile)
end

Given /^I have a talk tagged with "([^"]*)"$/ do |tag|
  @talk = Factory.create(:talk, :profile => @profile)
  @talk.tag!(tag)
end

When /^my profile's tags are calculated$/ do
  profile = Profile.find(@profile.id)
  profile.calculate_tags
  profile.save
end

Then /^my profile should have a "([^"]*)" tag$/ do |tag|
  profile = Profile.find(@profile.id)
  profile.has_tag?(tag).should == true
end

Given /^I have a stackoverflow profile tagged with "([^"]*)"$/ do |tag|
  profile = Profile.find(@profile.id)
  so_profile = Factory.create(:stack_overflow_profile, :profile => profile)
  profile.save
  so_profile.tag!(tag)
end

