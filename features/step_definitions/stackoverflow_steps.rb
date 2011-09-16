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

Then /^I should not see their StackOverflow profile$/ do
  And %Q{I should not see "Go to my StackOverflow Profile"}
end

Then /^I should see their StackOverflow profile$/ do
  And %Q{I should see "Go to my StackOverflow Profile"}
end

Given /^the other user has a StackOverflow profile$/ do
  VCR.use_cassette("other stackoverflow", :record => :all) do
    Factory.create(:stack_overflow_profile, :stack_overflow_id => "60336", :profile => @other_user.profile, :last_synced_date => DateTime.now)
    @other_user.profile.save
  end
end

Given /^I have a StackOverflow profile$/ do
  VCR.use_cassette("my stackoverflow", :record => :all) do
    so = Factory.create(:stack_overflow_profile, :stack_overflow_id => "60336", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    so.sync!
  end
end

When /^I edit my StackOverflow id$/ do
  VCR.use_cassette("edit stackoverflow", :record => :all) do
    profile = Profile.find(@profile.id)
    @old_questions = profile.stack_overflow_profile.questions.to_a
    @old_answers = profile.stack_overflow_profile.answers.to_a
    visit profile_knowledge_path(@profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => "5056"
    within("#sync_stack_overflow") do
      click_button "Save"
    end
  end
end

Then /^I should have my new StackOverflow questions$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.questions.count.should > 0
end

Then /^I should have my new StackOverflow answers$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.answers.count.should > 0
end

When /^I delete my StackOverflow profile$/ do
  visit profile_knowledge_path(@profile)
  profile = Profile.find(@profile.id)
  @old_questions = profile.stack_overflow_profile.questions.to_a
  @old_answers = profile.stack_overflow_profile.answers.to_a
  click_link "delete_stack_overflow"
end

Then /^I should not have a StackOverflow profile$/ do
  Profile.find(@profile.id).stack_overflow_profile.should be_nil
end

When /^I sync my StackOverflow account with id "([^"]*)"$/ do |stackoverflow_id|
  VCR.use_cassette("stack_overflow_#{stackoverflow_id}", :record => :all) do
    visit new_profile_stack_overflow_profile_path(@profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => stackoverflow_id
    click_button "Save"
  end
end
