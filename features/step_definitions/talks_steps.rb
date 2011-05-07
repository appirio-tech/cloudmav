When /^I add a talk$/ do
  visit new_profile_talk_path(@profile)
  @talk = Factory.build(:talk)
  fill_in "talk_title", :with => @talk.title
  fill_in "talk_description", :with => @talk.description
  fill_in "talk_slides_url", :with => @talk.slides_url
  click_button "Add"
end

Then /^the talk should be added$/ do
  profile = User.find(@user.id).profile
  profile.talks.select{ |t| t.title == @talk.title }.first.should_not be_nil
end

Given /^I have a talk$/ do
  @talk = Factory.build(:talk)
  profile = User.find(@user.id).profile
  profile.talks << @talk
  @talk.save
  profile.save
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

Then /^I should have just "([^"]*)"$/ do |name|
  profile = Profile.find(@profile.id)
  profile.activities.where(:name => name).first.should_not be_nil
end
