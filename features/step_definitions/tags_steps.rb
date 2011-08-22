Given /^I can manage tags$/ do
  profile = Profile.find(@profile.id)
  profile.can_manage_tags = true
  profile.save
end

When /^I add the tag "([^"]*)"$/ do |tag|
  visit new_tag_path
  fill_in :name, :with => tag
  click_button "Add"
end

Then /^there should be a tag "([^"]*)"$/ do |tag|
  Tag.where(:name => tag).first.should_not be_nil
end

When /^I change the tag "([^"]*)"'s synonyms to "([^"]*)"$/ do |tag, synonyms|
  tag = Tag.where(:name => tag).first
  visit edit_tag_path(tag)
  fill_in :synonyms, :with => synonyms
  click_button "Save"
end

Then /^the tag "([^"]*)"'s synonyms should be "([^"]*)"$/ do |tag, synonyms|
  tag = Tag.where(:name => tag).first
  synonyms.split(",").map{|s| s.strip}.each { |s| tag.synonyms.should include s }
end


