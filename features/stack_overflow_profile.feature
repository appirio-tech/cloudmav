Feature: StackOverflowProfile 

  As a user
  I want to sync with my StackOverflow account
  So that others can see my reputation

  Background:
    Given I am logged in
    And there are guidances
  
  Scenario: Sync with account
  
    When I sync my StackOverflow account
    Then I should have a StackOverflow profile
    And I should be awarded the "Stack Junkie" badge
    And I should have 10 coder points
    And I should learned "Syncing with your Stackoverflow Account"
    And my StackOverflow profile should be tagged
    And my profile should have my StackOverflow profile tags

  Scenario: Edit profile

    Given I have a StackOverflow profile
    When I edit my StackOverflow profile
    Then my StackOverflow profile should be updated

  Scenario: Don't see StackOverflow on users without StackOverflow

    Given there is another user
    When I view their code profile
    Then I should not see their StackOverflow profile

  Scenario: See StackOverflow on users with StackOverflow

    Given there is another user
    And the other user has a StackOverflow profile
    When I view their code profile
    Then I should see their StackOverflow profile
