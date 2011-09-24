Given /^I have a job "([^"]*)" from "([^"]*)" to "([^"]*)"$/ do |title, start_date, end_date|
  sd = Time.parse(start_date)
  ed = Time.parse(end_date)
  @job = Factory.create(:job, :profile => @profile, :title => title, :start_date => sd, :end_date => ed)
end

Then /^my job "([^"]*)" should have experience points$/ do |title|
  @profile.reload
  job = @profile.jobs.where(:title => title).first
  job.score(:experience_points).should > 0
end

