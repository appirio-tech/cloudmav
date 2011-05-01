When /^I schedule a presentation$/ do
  visit talk_path(@talk)
  click_link "Schedule a presentation"
  @presentation = Factory.build(:presentation)
  fill_in "presentation_date", :with => "3/10/2010"
  fill_in "presentation_time", :with => "8:30pm"
  fill_in "presentation_audience", :with => @presentation.audience
  fill_in "presentation_url", :with => @presentation.url
  click_button "Schedule Presentation"
end

Then /^the presentation should be added$/ do
  talk = Talk.find(@talk.id)
  talk.presentations.count.should == 1
end
