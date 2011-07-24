Given /^there are (\d+) users$/ do |number|
  number.to_i.times do
    Factory.create(:user)
  end
end

When /^the daily admin email is sent$/ do
  AdminEmailer.daily_report.deliver
  @email = ActionMailer::Base.deliveries.first
end

Then /^the email should show (\d+) total users$/ do |user_count|
  @email.body.should include "Total users = #{user_count}"
end

