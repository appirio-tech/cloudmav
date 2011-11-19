When /^I view the points page$/ do
  visit points_path
end

Then /^I should see how the points are calculated$/ do
  page.has_css?("#points_explained").should == true
end
