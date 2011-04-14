When /^I synch my StackOverflow account$/ do
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
  @stack_overflow_profile = Factory.create(:stack_overflow_profile, :profile => @profile)
end

When /^I edit my StackOverflow profile$/ do
  VCR.use_cassette("stack_overflow_update", :record => :all) do
    visit edit_profile_stack_overflow_profile_path(@profile, @stack_overflow_profile)
    fill_in "stack_overflow_profile_stack_overflow_id", :with => "60336"
    click_button "Save"
  end
end

Then /^my StackOverflow profile should be updated$/ do
  @stack_overflow_profile.reload
  @stack_overflow_profile.stack_overflow_id.should == "60336"
end

