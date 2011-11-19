Given /^there are talks$/ do
  3.times do
    profile = Factory.create(:user).profile
    Factory.create(:talk, :profile => profile)
  end
end

When /^I search talks$/ do
  result = mock()
  result.stubs(:results).returns(Talk.all)
  Talk.stubs(:search).returns(result)
  visit talk_search_path
  click_button "Search"
end

Then /^I should see my talk search results$/ do
  page.has_css?("#talk_search_results").should == true
end
