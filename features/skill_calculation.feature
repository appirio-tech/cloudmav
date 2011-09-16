Feature: Skill Calculation

  As a user
  I want to have my work and points broken down by skills
  So that I can be rated on those skills

  Scenario: Talk with skill tag
  
    Given I am a user
    And there is a skill "ruby" for tags "ruby"
    And I have a talk worth 30 speaker points tagged with "ruby"
    When my profile's skills are calculated
    Then my talk should have 30 "ruby" points 
    And my talk should have 30 "ruby" speaker points
    And I should have 30 "ruby" skill points
    And I should have 30 speaker points
    And I should have 30 total points
  
  Scenario: Talk and Repo with skill tag
  
    Given I am a user
    And there is a skill "ruby" for tags "ruby"
    And I have a talk worth 30 speaker points tagged with "ruby"
    And I have a GitHub repo worth 53 coder points tagged with "ruby"
    When my profile's skills are calculated
    Then my talk should have 30 "ruby" speaker points
    And my GitHub repo should have 53 "ruby" coder points
    And I should have 83 "ruby" skill points
    And I should have 30 speaker points
    And I should have 53 coder points
    And I should have 83 total points

  Scenario: Talk with 2 skill tag
  
    Given I am a user
    Given there is a skill "ruby" for tags "ruby"
    And there is a skill "c#" for tags "c#, csharp"
    And I have a talk worth 30 speaker points tagged with "ruby, csharp"
    When my profile's skills are calculated
    Then my talk should have 15 "ruby" speaker points
    And my talk should have 15 "c#" speaker points
    And I should have 15 "ruby" skill points
    And I should have 15 "c#" skill points
    And I should have 30 speaker points
    And I should have 30 total points