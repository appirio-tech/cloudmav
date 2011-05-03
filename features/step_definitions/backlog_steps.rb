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

Given /^I added a backlog item$/ do
  @backlog_item = Factory.create(:backlog_item, :author => @profile)
end

When /^I update my backlog item$/ do
  visit edit_backlog_item_path(@backlog_item)
  fill_in "backlog_item_title", :with => "updated title"
  click_button "Save"
end

Then /^the backlog item should be updated$/ do
  backlog_item = BacklogItem.find(@backlog_item.id)
  backlog_item.title.should == "updated title"
end


