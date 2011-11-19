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

When /^I add links to a talk$/ do
  visit edit_profile_talk_path(@profile, @talk)
  fill_in "talk_links_block", :with => "www.github.com"
  click_button "Save"
end

Then /^the talk should have links$/ do
  @talk.reload
  @talk.links.count.should == 1
  @talk.links[0].should == "http://www.github.com"
end