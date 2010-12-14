When /^I add a talk$/ do
  visit new_my_talk_path
  @talk = Factory.build(:talk)
  fill_in :title, :with => @talk.title
  fill_in :description, :with => @talk.description
  fill_in "Slides url", :with => @talk.slides_url
  click_button "Add"
  And %Q{I should be redirected}
end

Then /^the talk should be added$/ do
  profile = User.find(@user.id).profile
  profile.talks.select{ |t| t.title == @talk.title }.first.should_not be_nil
end
