
Given /^there is a company "([^"]*)"$/ do |name|
  Factory.create(:company, :name => name)
end

When /^I add a job with "([^"]*)"$/ do |company_name|
  visit new_job_path(:username => @profile.username)
  @job = Factory.build(:job)
  fill_in "job_company_name", :with => company_name
  fill_in "job_title", :with => @job.title
  fill_in "job_description", :with => @job.description
  fill_in "start_date", :with => @job.start_date.strftime("%m/%d/%y")
  fill_in "end_date", :with => @job.end_date.strftime("%m/%d/%y")
  click_button "Add"
end

Then /^the job should be added$/ do
  profile = Profile.find(@profile.id)
  profile.jobs.where(:title => @job.title).first.should_not be_nil
  Job.where(:title => @job.title).first.should_not be_nil
end

Then /^there should be the company "([^"]*)"$/ do |company_name|
  Company.where(:name => company_name).first.should_not be_nil
end

Given /^I have a job$/ do
  @job = Factory.create(:job, :profile => @profile)
end

When /^I edit my job$/ do
  visit edit_job_path(@job)
  fill_in "job_description", :with => "Updated description"
  click_button "Save"
end

Then /^the job should be updated$/ do
  profile = Profile.find(@profile.id)
  profile.jobs.where(:title => @job.title).first.description.should == "Updated description"
  Job.where(:title => @job.title).first.description.should == "Updated description"
end

When /^I add a job with "([^"]*)" where I worked on "([^"]*)"$/ do |company_name, tags|
  visit new_job_path(:username => @profile.username)
  @job = Factory.build(:job)
  fill_in "job_company_name", :with => company_name
  fill_in "job_title", :with => @job.title
  fill_in "job_description", :with => @job.description
  fill_in "start_date", :with => @job.start_date.strftime("%m/%d/%y")
  fill_in "end_date", :with => @job.end_date.strftime("%m/%d/%y")
  fill_in "job_tags_text", :with => tags
  click_button "Add"  
end

Then /^the job should be tagged with "([^"]*)"$/ do |tags|
  profile = Profile.find(@profile.id)
  job = profile.jobs.where(:title => @job.title).first 
  tags.split(',').map{|s| s.strip}.each do |t|
    job.has_tag?(t).should == true
  end
end

Then /^the company "([^"]*)" should be tagged with "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^my experience profile should be tagged with "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

