When /^I view the admin typography page$/ do
  visit admin_typography_path
end

Then /^I should see all heading types$/ do
  And %Q{I should see "Heading 1"}
end

When /^I view the admin form page$/ do
  visit admin_form_path
end

Then /^I should see text input fields$/ do
  page.has_css?("#text_field_1").should == true
  page.has_css?("#text_field_2").should == true
end

Then /^I should see submit button$/ do
  page.has_css?("#submit").should == true
end

