
Given /^there is a company$/ do
  @company = Factory.create(:company)
end

Given /^there is an employee tagged "([^"]*)"$/ do |tag|
  @employee = Factory.create(:profile)
  @job = Factory.create(:job, :profile => @employee, :company => @company)
  @job.tag! tag
end

When /^the company's tags are calculated$/ do
  company = Company.find(@company.id)
  company.calculate_tags
  company.save
end

Then /^the company should be tagged "([^"]*)"$/ do |tag|
  company = Company.find(@company.id)
  company.has_tag?(tag).should == true
end
