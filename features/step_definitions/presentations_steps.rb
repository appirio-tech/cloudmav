When /^I schedule a presentation$/ do
  visit talk_path(@talk)
  click_link "Schedule a presentation"
  @presentation = Factory.build(:presentation)
  fill_in "presentation_date_string", :with => "3/10/2010"
  fill_in "presentation_time_string", :with => "8:30pm"
  fill_in "presentation_audience", :with => @presentation.audience
  fill_in "presentation_url", :with => @presentation.url
  click_button "Save"
end

Then /^the presentation should be added$/ do
  talk = Talk.find(@talk.id)
  talk.presentations.count.should == 1
end

Given /^the talk has a presentation$/ do
  @presentation = Factory.create(:presentation, :talk => @talk)
end

When /^I edit the presentation$/ do
  visit edit_talk_presentation_path(@talk, @presentation)
  fill_in "presentation_url", :with => "whatever"
  click_button "Save"
end

Then /^the presentation should be edited$/ do
  presentation = Presentation.find(@presentation.id)
  presentation.url.should == "whatever"
end


