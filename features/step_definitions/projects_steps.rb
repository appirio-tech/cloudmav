When /^I add a project$/ do
  @project = Factory.build(:project)
  visit new_my_project_path
  fill_in :name, :with => @project.name
  fill_in :start_date, :with => @project.start_date
  fill_in :end_date, :with => @project.end_date
  click_button "Add"
  And "I should be redirected"
end

Then /^the project should be added$/ do
  profile = Profile.find(@profile.id)
  profile.projects.last.name.should == @project.name
end
