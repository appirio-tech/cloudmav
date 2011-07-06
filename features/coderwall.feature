Feature: CoderWallProfile 

  As a user
  I want to sync with my CoderWall account
  So that others can see my badges

  Background:
    Given I am logged in
    And there are guidances
  
  Scenario: Sync with account
  
    When I sync my CoderWall account
    Then I should have a CoderWall profile
    #And I should be awarded the "Stack Junkie" badge
    #And I should have knowledge points for StackOverflow
    #And I should learned "Syncing with your Stackoverflow Account"
    #And my StackOverflow profile should be tagged
    #And my profile should have my StackOverflow profile tags
    #And I should have my top questions and top answers
