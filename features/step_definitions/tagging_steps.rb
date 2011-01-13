Given /^there is a talk$/ do
  @talk = Factory.create(:talk, :profile => @profile)
end

When /^I tag the talk with "([^"]*)"$/ do |tag|
  visit edit_talk_path(@talk)
  fill_in "talk_tags_text", :with => tag
  click_button "Save"
  And "I should be redirected"
end

Then /^there should be a "([^"]*)" tag$/ do |tag|
  Tag.named(tag).first.should_not be_nil
end

Then /^the talk should be tagged with "([^"]*)"$/ do |tag|
  talk = Talk.find(@talk.id)
  talk.has_tag?(tag).should == true
end
