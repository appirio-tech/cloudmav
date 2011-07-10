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
    And I should have coder points for CoderWall
    And I should have badges on my CoderWall profile

  Scenario: Don't see CoderWall on users without CoderWall

    Given there is another user
    When I view their code profile
    Then I should not see their CoderWall profile

  Scenario: See CoderWall on users with CoderWall

    Given there is another user
    And the other user has a CoderWall profile
    When I view their code profile
    Then I should see their CoderWall profile

  Scenario: Edit CoderWall

    Given I have a CoderWall profile
    When I edit my CoderWall username
    Then I should have a CoderWall profile
    And my old CoderWall badges should be deleted
    And I should have my new CoderWall badges

  Scenario: Delete CoderWall

    Given I have a CoderWall profile
    When I delete my CoderWall profile
    Then I should not have a CoderWall profile
