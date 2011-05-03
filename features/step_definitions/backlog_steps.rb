When /^I add an item to the backlog$/ do
  visit new_backlog_item_path
  @backlog_item = Factory.build(:backlog_item)
  fill_in "backlog_item_title", :with => @backlog_item.title
  fill_in "backlog_item_description", :with => @backlog_item.description
  click_button "Save"
end

Then /^the item should be on the backlog$/ do
  And %Q{I should see "#{@backlog_item.title}"}
end

