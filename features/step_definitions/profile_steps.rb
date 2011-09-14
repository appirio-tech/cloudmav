When /^I view my profile$/ do
  visit profile_path(@profile)
end

Then /^I should be able to view the menu$/ do
  within("#profile_menu") do
    And %Q{I should see "Summary"}
    And %Q{I should see "Experience"}
    And %Q{I should see "Knowledge"}
    And %Q{I should see "Code"}
    And %Q{I should see "Writing"}
    And %Q{I should see "Speaking"}
    And %Q{I should see "Social"}
  end
end
