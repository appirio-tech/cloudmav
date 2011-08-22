Given /^there are users with talks/ do
  @joe = Factory.create(:user).profile
  @joe.name = "Joe"

  Factory.create(:talk, :profile => @joe, :presentation_date => 3.weeks.ago)
  Factory.create(:talk, :profile => @joe, :presentation_date => 3.days.ago)
  Factory.create(:talk, :profile => @joe, :presentation_date => 1.week.from_now)
end

When /^it is one week before their talks$/ do
  Talk.send_reminders!
end

Then /^they should be reminded of their upcoming talk/ do
  email = ActionMailer::Base.deliveries.last
  email.subject.should == "Talk Reminder"
end

