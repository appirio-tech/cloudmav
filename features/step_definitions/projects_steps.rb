When /^I add a project$/ do
  @project = Factory.build(:project)
  visit new_my_project_path
  fill_in :name, :with => @project.name
  fill_in :start_date, :with => @project.start_date.strftime("%m/%d/%y")
  fill_in :end_date, :with => @project.end_date.strftime("%m/%d/%y")
  click_button "Add"
  And "I should be redirected"
end

Then /^the project should be added$/ do
  profile = Profile.find(@profile.id)
  profile.projects.last.name.should == @project.name
end

When /^I add a project with technologies "([^"]*)"$/ do |technologies|
  @project = Factory.build(:project)
  visit new_my_project_path
  fill_in :name, :with => @project.name
  fill_in :start_date, :with => @project.start_date.strftime("%m/%d/%y")
  fill_in :end_date, :with => @project.end_date.strftime("%m/%d/%y")
  fill_in :technologies, :with => technologies
  click_button "Add"
  And "I should be redirected"
end

Then /^technology "([^"]*)" should be added$/ do |name|
  Technology.where(:name => name).first.should_not be_nil
end

Then /^I should have experience in "([^"]*)"$/ do |name|
  profile = Profile.find(@profile.id)
  profile.experiences.with(name).first.should_not be_nil
end
