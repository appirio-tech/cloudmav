Feature: GitHubProfile 

  As a user
  I want to synch with my GitHub account
  So that others can see source and followers
  
  Scenario: Synch with account
  
    Given I am logged in
    And there are guidances
    When I synch my GitHub account
    Then I should have a GitHub profile
    And I should have a collection of my repos
    And I should be awarded the "Git R Done" badge
    And I should have 10 coder points
    And I should learned "Synching with your GitHub Account"
    And my GitHub profile should be tagged
    And my profile should have my GitHub profile tags

  Scenario: Don't see GitHub on users without GitHub

    Given there is another user
    When I view their code profile
    Then I should not see their GitHub profile

  Scenario: See GitHub on users with GitHub

    Given there is another user
    And the other user has a GitHub profile
    When I view their code profile
    Then I should not see their GitHub profile
