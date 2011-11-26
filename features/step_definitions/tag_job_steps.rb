Given /^I have a job from "([^"]*)" thru "([^"]*)"$/ do |start_date, end_date|
  sd = Time.parse(start_date)
  ed = Time.parse(end_date)
  @job = Factory.create(:job, :start_date => sd, :end_date => ed, :profile => @profile)
  @job.earn(1000, :experience_points, "for job", @job)
end

When /^I tag the job with "([^"]*)"$/ do |tag|
  visit edit_profile_job_path(@profile, @job)
  fill_in :job_tags_text, :with => tag
  click_button "Save"
end

Then /^the job should be tagged with "([^"]*)"$/ do |tag|
  @job.reload
  @job.has_tag?(tag).should == true
end

Then /^the job should have "([^"]*)" experience points$/ do |skill_name|
  @job.reload
  @job.skill_score_for_type(skill_name, :experience).should > 0
end