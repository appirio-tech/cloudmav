Feature: GitHub Repository Scoring

  As a user
  I want my git hub repositories scored
  So that I can know which git hub repositories are the best
  
  Scenario: GitHub Repository Scoring
  
    Given I am a user
    And I have a GitHub profile
    And I have a GitHub repository 
    When my profile is scored
    Then my GitHub repository should have a score  