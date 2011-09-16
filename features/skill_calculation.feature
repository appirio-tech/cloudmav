Feature: Skill Calculation

  As a user
  I want to have my work and points broken down by skills
  So that I can be rated on those skills

  Scenario: 1 Item with skill tag
  
    Given I am a user
    And there is a skill "ruby" for tags "ruby"
    And I have a talk worth 30 speaker points tagged with "ruby"
    When my profile's skills are calculated
    Then my talk should have 30 "ruby" speaker points
    And I should have 30 "ruby" skill points
    And I should have 30 speaker points
    And I should have 30 total points
  
# 
# 
# 
# Scenario 2:
# 
# 
# 
# Given there is a skill "ruby" for tags "ruby"
# 
# And there is a user
# 
# And the user has a talk worth "30" speaker points tagged with "ruby"
# 
# And the user has a GitHub repo worth "53" coder points tagged with "ruby"
# 
# Then the talk should have "30" "ruby" speaker points
# 
# And the GitHub repo should have "53" "ruby" coder points
# 
# And the user should have "83" "ruby" points
# 
# And the user should have "30" speaker points
# 
# And the user should have "53" coder points
# 
# And the user should have "83" total points
# 
# 
# 
# Scenario 3:
# 
# 
# 
# Given there is a skill "ruby" for tags "ruby"
# 
# And there is a skill "c#" for tags "c#, csharp"
# 
# And there is a user
# 
# And the user has a talk worth "30" speaker points tagged with "ruby, csharp"
# 
# Then the talk should have "15" "ruby" speaker points
# 
# And the talk should have "15" "c#" speaker points
# 
# And the user should have "15" "ruby" points
# 
# And the user should have "15" "c#" points
# 
# And the user should have "30" speaker points
# 
# And the user should have "30" total points