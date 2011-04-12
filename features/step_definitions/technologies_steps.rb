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
end

Then /^the technology should be added$/ do
  technology = Technology.where(:name => @technology.name).first
  technology.should_not be_nil
end

Given /^there is a technology$/ do
  @technology = Factory.create(:technology)
end

When /^I edit a technology$/ do
  visit edit_technology_path(@technology)
  fill_in :name, :with => "Updated name"
  click_button "Save"
end

Then /^the technology should be updated$/ do
  technology = Technology.find(@technology.id)
  technology.name.should == "Updated name"
end

When /^I delete a technology$/ do
  visit technologies_path
  click_button "delete_#{@technology.id}"
end

Then /^the techology should be deleted$/ do
  Technology.where(:id => @technology.id).count.should == 0
end

