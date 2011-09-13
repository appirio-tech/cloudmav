When /^I tag the talk with "([^"]*)"$/ do |tag|
  visit edit_profile_talk_path(@profile, @talk)
  fill_in "talk_tags_text", :with => tag
  click_button "Save"
end

Then /^there should be a "([^"]*)" tag$/ do |tag|
  Tag.where(:name => tag).first.should_not be_nil
end

Then /^the talk should be tagged with "([^"]*)"$/ do |tag|
  talk = Talk.find(@talk.id)
  t = Tag.where(:name => tag).first
  talk.has_tag?(t).should == true
end

Given /^there is a tag "([^"]*)"$/ do |tag|
  @tag = Factory.create(:tag, :name => tag)
end

Then /^there should be a tag "([^"]*)"$/ do |tag|
  Tag.named(tag).first.should_not be_nil
end

Given /^the talk is tagged "([^"]*)"$/ do |tag|
  @talk.tags_text = tag
  @talk.save
  @talk.retag!
end

Then /^the talk should not be tagged with "([^"]*)"$/ do |tag|
  talk = Talk.find(@talk.id)
  t = Tag.where(:name => tag).first
  talk.has_tag?(t).should == false
end

Then /^there should be no taggings$/ do
  Tagging.count.should == 0
end

Given /^there is a tag "([^"]*)" with synonyms "([^"]*)"$/ do |tag, synonyms|
  @tag = Factory.create(:tag, :name => tag)
  synonyms.split(',').each {|s| @tag.add_synonym(s) }
  @tag.save
end

Then /^there should not be a tag "([^"]*)"$/ do |tag|
  Tag.where(:name => tag).first.should be_nil
end

