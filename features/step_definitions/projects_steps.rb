When /^I add the project$/ do
  click_button "Add"
end

When /^I enter my project information$/ do
  @project = Factory.build(:project)
  visit new_my_project_path
  fill_in :name, :with => @project.name
  fill_in :start_date, :with => @project.start_date.strftime("%m/%d/%y")
  fill_in :end_date, :with => @project.end_date.strftime("%m/%d/%y")
end

When /^I enter the technologies "([^"]*)"$/ do |technologies|
  fill_in :technologies, :with => technologies
end

Then /^the project should be added$/ do
  And "I should be redirected"
  profile = Profile.find(@profile.id)
  profile.projects.last.name.should == @project.name
end

Then /^technology "([^"]*)" should be added$/ do |name|
  Technology.where(:name => name).first.should_not be_nil
end

Then /^I should have experience in "([^"]*)"$/ do |name|
  profile = Profile.find(@profile.id)
  profile.experiences.with(name).first.should_not be_nil
end

When /^I enter the start date as "([^"]*)"$/ do |date|
  fill_in :start_date, :with => date
end

When /^I enter the end date as "([^"]*)"$/ do |date|
  fill_in :end_date, :with => date
end

Then /^the project should not be added$/ do
  project = Project.where(:name => @project.name).first
  project.should be_nil
end

Then /^I should get the error message "([^"]*)"$/ do |message|
  And %Q{I should see "#{message}" within "#error_explanation"}
end

