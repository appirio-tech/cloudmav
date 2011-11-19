Feature: Talk Scoring

  As a user
  I want my talk scored
  So that I can know which talks are the best
  
  Scenario: Talk Scoring
  
    Given I am a user
    And I have a talk 
    When my profile is scored
    Then my talk should have a score