When /^I view the admin typography page$/ do
  visit admin_typography_path
end

Then /^I should see all heading types$/ do
  And %Q{I should see "Heading 1"}
end
