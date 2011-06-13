Feature: GitHubProfile 

  As a user
  I want to sync with my GitHub account
  So that others can see source and followers
  
  Scenario: Sync with account
  
    Given I am logged in
    And there are guidances
    When I sync my GitHub account
    Then I should have a GitHub profile
    And I should have a collection of my repos
    And I should be awarded the "Git R Done" badge
    And I should have 10 coder points
    And I should learned "Syncing with your GitHub Account"
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
    Then I should see their GitHub profile

  Scenario: Edit GitHub

    Given I am logged in
    And there are guidances
    And I have a GitHub profile
    When I edit my GitHub id
    Then I should have a GitHub profile
    And my old GitHub events should be deleted
    And my old GitHub repositories should be deleted
    And I should have my new GitHub repositories

 Scenario: Delete GitHub

   Given I am logged in
   And there are guidances
   And I have a GitHub profile
   When I delete my GitHub profile
   Then I should not have a GitHub profile
   And I should not have the "Git R Done" badge
   And my old GitHub events should be deleted
   And my old GitHub repositories should be deleted
   And I should have 0 coder points
