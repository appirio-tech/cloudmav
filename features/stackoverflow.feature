Feature: StackOverflowProfile 

  As a user
  I want to sync with my StackOverflow account
  So that others can see my reputation

  Background:
    Given I am logged in
  
  Scenario: Sync with account
  
    When I sync my StackOverflow account
    Then I should have a StackOverflow profile
    And I should be awarded the "Stack Junkie" badge
    And I should have knowledge points for StackOverflow
    And my StackOverflow profile should be tagged
    And my profile should have my StackOverflow profile tags
    And I should have my top questions and top answers

  Scenario: Don't see StackOverflow on users without StackOverflow
  
    Given there is another user
    When I view their knowledge profile
    Then I should not see their StackOverflow profile
  
  Scenario: See StackOverflow on users with StackOverflow
  
    Given there is another user
    And the other user has a StackOverflow profile
    When I view their knowledge profile
    Then I should see their StackOverflow profile
  
  Scenario: Edit StackOverflow
  
    Given I have a StackOverflow profile
    When I edit my StackOverflow id
    Then I should have a StackOverflow profile
    And I should have my new StackOverflow questions
    And I should have my new StackOverflow answers
  
  Scenario: Delete StackOverflow
  
    Given I have a StackOverflow profile
    When I delete my StackOverflow profile
    Then I should not have a StackOverflow profile

