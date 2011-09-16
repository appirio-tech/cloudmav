Given /^there is a skill "([^"]*)" for tags "([^"]*)"$/ do |skill_name, tags|
  t = tags.split(",").map{|x| x.strip}
  Factory.create(:available_skill, :name => skill_name, :tags => t)
end

Given /^the user has a talk worth "([^"]*)" speaker points tagged with "([^"]*)"$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the talk should have "([^"]*)" "([^"]*)" speaker points$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the user should have "([^"]*)" "([^"]*)" points$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the user should have "([^"]*)" speaker points$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the user should have "([^"]*)" total points$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
