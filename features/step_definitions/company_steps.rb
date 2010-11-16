
When /^I add a company "([^"]*)"$/ do |name|
  @company = Factory.build(:company, :name => name)
  And %Q{I go to the add a company page}
  fill_in :name, :with => @company.name
  click_button "Add"
  And %Q{I should be redirected}
end

Then /^the company should be added$/ do
  company = Company.where(:name => @company.name).first
  company.should_not be_nil
end
