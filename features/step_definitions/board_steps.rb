Given /^there are backlog items$/ do
  @backlog_items = []
  10.times { @backlog_items << Factory.create(:backlog_item, :author => Factory.create(:user).profile) }
end

Given /^there are events$/ do
end

When /^I view my board$/ do
  visit board_path
end

Then /^I should see backlog items$/ do
  @backlog_items.each do |i|
    And %Q{I should see "#{i.title}"}
  end
end

Then /^I should see an event log$/ do
  page.has_css?("[data-type=event]")
end



