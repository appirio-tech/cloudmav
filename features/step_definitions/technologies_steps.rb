Given /^I can manage technology$/ do
  profile = Profile.find(@profile.id)
  profile.is_moderator = true
  profile.save 
end

When /^I add a technology$/ do
  visit new_technology_path
  @technology = Factory.build(:technology)
  fill_in :name, :with => @technology.name
  click_button "Save"
  And "I should be redirected"
end

Then /^the technology should be added$/ do
  technology = Technology.where(:name => @technology.name).first
  technology.should_not be_nil
end
