When /^I sync my StackOverflow account$/ do
  VCR.use_cassette("stack_overflow", :record => :all) do
    visit new_profile_stack_overflow_profile_path(@profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => '60336'
    click_button "Save"
  end
end

Then /^I should have a StackOverflow profile$/ do
  profile = User.find(@user.id).profile
  profile.stack_overflow_profile.should_not be_nil
end

Then /^I should have knowledge points for StackOverflow$/ do
  profile = Profile.find(@profile.id)
  expected_points = 10 + (profile.stack_overflow_profile.reputation / 100)
  profile.score(:knowledge_points).should == expected_points
end

Then /^my StackOverflow profile should be tagged$/ do
  profile = User.find(@user.id).profile
  stack_overflow_profile = profile.stack_overflow_profile
  stack_overflow_profile.tags.count.should > 0
end

Then /^my profile should have my StackOverflow profile tags$/ do
  profile = User.find(@user.id).profile
  profile.tags.count.should > 0
end

Then /^I should have my top questions and top answers$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.questions.should_not be_nil
  profile.stack_overflow_profile.answers.should_not be_nil
end

