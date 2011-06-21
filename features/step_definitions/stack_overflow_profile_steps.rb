When /^I sync my StackOverflow account$/ do
  VCR.use_cassette("stack_overflow", :record => :all) do
    visit new_profile_stack_overflow_profile_path(@profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => '60336'
    click_button "Save"
  end
end

When /^I view their knowledge profile$/ do
  visit profile_knowledge_path(@other_user.profile)
end

Then /^I should have a StackOverflow profile$/ do
  profile = User.find(@user.id).profile
  profile.stack_overflow_profile.should_not be_nil
end

Then /^I should learned "([^"]*)"$/ do |title|
  profile = User.find(@user.id).profile
  profile.knows?(title).should == true
end

Given /^there are guidances$/ do
  Virgil::Dsl.class_eval(File.read('lib/guidance.rb'))
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

Given /^I have a StackOverflow profile$/ do
  VCR.use_cassette("my stackoverflow", :record => :all) do
    so = Factory.create(:stack_overflow_profile, :stack_overflow_id => "60336", :profile => @profile, :last_synced_date => DateTime.now)
    @profile.save
    so.sync!
  end
end

Then /^my StackOverflow profile should be updated$/ do
  @stack_overflow_profile.reload
  @stack_overflow_profile.stack_overflow_id.should == "60336"
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

Then /^I should not see their StackOverflow profile$/ do
  And %Q{I should not see "Go to my StackOverflow Profile"}
end

Then /^I should have knowledge points for StackOverflow$/ do
  profile = Profile.find(@profile.id)
  expected_points = 10 + (profile.stack_overflow_profile.reputation / 100)
  profile.score(:knowledge_points).should == expected_points
end

When /^I edit my StackOverflow id$/ do
  VCR.use_cassette("edit stackoverflow", :record => :all) do
    profile = Profile.find(@profile.id)
    @old_questions = profile.stack_overflow_profile.questions.to_a
    @old_answers = profile.stack_overflow_profile.answers.to_a
    @old_answer_events = StackOverflowAnswerAddedEvent.all.to_a
    @old_question_events = StackOverflowQuestionAddedEvent.all.to_a
    visit profile_knowledge_path(@profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => "5056"
    click_button "stack_overflow_profile_submit"
  end
end

Then /^my old StackOverflow questions should be deleted$/ do
  old_ids = @old_questions.map(&:id)
  StackOverflowQuestion.any_in(_id: old_ids).count.should == 0
end

Then /^my old StackOverflow answers should be deleted$/ do
  old_ids = @old_questions.map(&:id)
  StackOverflowAnswer.any_in(_id: old_ids).count.should == 0
end

Then /^I should have my new StackOverflow questions$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.questions.count.should > 0
end

Then /^I should have my new StackOverflow answers$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.answers.count.should > 0
end

Then /^my old StackOverflow events should be deleted$/ do
  old_ids = @old_question_events.map(&:id)
  StackOverflowQuestionAddedEvent.any_in(_id: old_ids).count.should == 0
  old_ids = @old_answer_events.map(&:id)
  StackOverflowAnswerAddedEvent.any_in(_id: old_ids).count.should == 0
end

When /^I delete my StackOverflow profile$/ do
  visit profile_knowledge_path(@profile)
  profile = Profile.find(@profile.id)
  @old_questions = profile.stack_overflow_profile.questions.to_a
  @old_answers = profile.stack_overflow_profile.answers.to_a
  @old_answer_events = StackOverflowAnswerAddedEvent.all.to_a
  @old_question_events = StackOverflowQuestionAddedEvent.all.to_a
  click_link "delete_stack_overflow"
end

Then /^I should not have a StackOverflow profile$/ do
  Profile.find(@profile.id).stack_overflow_profile.should be_nil
end

When /^there was an error while syncing my StackOverflow profile$/ do
  e = StackOverflowProfileSyncEvent.last
  e.error_message = "There is an error!"
  e.save
end

Then /^I should see an error message on my StackOverflow profile page$/ do
  visit profile_knowledge_path(@profile)
  And %Q{I should see "There was an error while syncing"}
end


Then /^I should have my top questions and top answers$/ do
  profile = Profile.find(@profile.id)
  profile.stack_overflow_profile.top_questions.should_not be_nil
  profile.stack_overflow_profile.top_answers.should_not be_nil
end

