Given /^there is a company$/ do
  @company = Factory.create(:company)
end

When /^I view the company$/ do
  visit company_path(@company)
end

Then /^I should see the company's info$/ do
  Then %Q{I should see "#{@company.name}"}
end
