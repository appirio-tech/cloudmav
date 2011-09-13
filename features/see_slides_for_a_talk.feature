Feature: See Slides for a Talk

  As a user
  I want to see the slides for a talk
  So that I can look learn information

  Scenario: User does not have a Slide Share account

    Given there is a user
    And the user has a talk
    When I am looking at the talk
    Then I should see the user does not have a Slide Share account

  Scenario: Talk not added to Slide Share
  
    Given there is a user
    And the user has a talk
    And the user has a Slide Share profile
    When I am looking at the talk
    Then I should see the user has not added the slides to Slide Share yet
  
  Scenario: Talk has slides
  
    Given there is a user
    And the user has a talk
    And the user has a Slide Share profile
    And the talk is on Slide Share
    When I am looking at the talk
    Then I should be able to view the slides
