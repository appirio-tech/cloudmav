Feature: GitHubProfile 

  As a user
  I want to synch with my GitHub account
  So that others can see source and followers
  
  Scenario: Synch with account
  
    Given I am logged in
    And there are guidances
    When I synch my GitHub account
    Then I should have a GitHub profile
    And I should be awarded the "Git R Done" badge
    And I should have 10 coder points
    And I should learned "Synching with your GitHub Account"
