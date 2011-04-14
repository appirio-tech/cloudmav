Given /^there are users with presentations$/ do
  @joe = Factory.create(:user).profile
  @joe.name = "Joe"

  @talk = Factory.create(:talk, :profile => @joe)
  Factory.create(:presentation, :presentation_date => 3.weeks.ago, :talk => @talk)
  Factory.create(:presentation, :presentation_date => 3.days.ago, :talk => @talk)
  Factory.create(:presentation, :presentation_date => 1.week.from_now, :talk => @talk)
end

When /^it is one week before there presentation$/ do
  Presentation.send_reminders!
end

Then /^they should be reminded of their upcoming presentation$/ do
  email = ActionMailer::Base.deliveries.last
  email.subject.should == "Presentation Reminder"
end

