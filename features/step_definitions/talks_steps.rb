When /^I add a talk$/ do
  visit new_profile_talk_path(@profile)
  @talk = Factory.build(:talk)
  fill_in "talk_title", :with => @talk.title
  fill_in "talk_description", :with => @talk.description
  click_button "Add"
end

Then /^the talk should be added$/ do
  profile = User.find(@user.id).profile
  profile.talks.select{ |t| t.title == @talk.title }.first.should_not be_nil
end

When /^I edit the talk$/ do
  visit edit_profile_talk_path(@profile, @talk)
  fill_in "talk_title", :with => "Updated Talk"
  click_button "Save"
end

Then /^the talk should be updated$/ do
  talk = Talk.find(@talk.id)
  talk.title.should == "Updated Talk"
end
